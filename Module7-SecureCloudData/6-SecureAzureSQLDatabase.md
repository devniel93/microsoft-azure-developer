# Protección de Azure SQL Database

## _Configuración de un entorno de espacio aislado_

1. Creación de una instancia de Azure SQL Database
Configurar variables:
```
# Set an admin login and password for your database
export ADMINLOGIN='admindevniel'
export PASSWORD='Devniel93##@@__'
# Set the logical SQL server name. We'll add a random string as it needs to be globally unique.
export SERVERNAME=server$RANDOM
export RESOURCEGROUP=learn-9f9f9e94-3f9d-4df8-a122-2132681320e3
# Set the location, we'll pull the location from our resource group.
export LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')
```

Crear el servidor logico en Azure SQL Database:
```
az sql server create \
    --name $SERVERNAME \
    --resource-group $RESOURCEGROUP \
    --location $LOCATION \
    --admin-user $ADMINLOGIN \
    --admin-password "$PASSWORD"
```
Crear la BD en el servidor logica usando una plantilla con tablas y datos llenadas previamente
```
az sql db create --resource-group $RESOURCEGROUP \
    --server $SERVERNAME \
    --name marketplaceDb \
    --sample-name AdventureWorksLT \
    --service-objective Basic
```

Obtener cadena de conexion de la BD
```
az sql db show-connection-string --client sqlcmd --name marketplaceDb --server $SERVERNAME | jq -r
```
sqlcmd -S tcp:server19870.database.windows.net,1433 -d marketplaceDb -U admindevniel -P Devniel93##@@__ -N -l 30

2. Creación y configuración de una máquina virtual Linux
Crear la VM. Como resultado se obtiene la IP Publica.
```
az vm create \
  --resource-group $RESOURCEGROUP \
  --name appServer \
  --image UbuntuLTS \
  --size Standard_DS2_v2 \
  --generate-ssh-keys
```

Conectarse por ssh con la IP Publica
```
ssh 40.86.164.64
```

Instalar `mssql-tools` en la VM Linux para conectarse a la BD a traves de `sqlcmd`
```
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
```

## _Reglas de firewall_
Azure SQL Database tiene un firewall integrado que se usa para permitir o denegar el acceso de red al propio servidor de base de datos y a las bases de datos individuales. Inicialmente, todo el acceso público a su instancia de Azure SQL Database está bloqueado por el firewall de SQL Database. Para acceder a un servidor de bases de datos, debe especificar una o varias reglas de firewall de IP de nivel de servidor que permitan acceder a Azure SQL Database. 

Según el nivel, las reglas que se pueden aplicar serán como siguen:

- Reglas de firewall de nivel de servidor:
    - Permitir el acceso a servicios de Azure
    - Reglas de direcciones IP
    - Reglas de red virtual

- Reglas de firewall de nivel de base de datos:
    - Reglas de direcciones IP

### Reglas de firewall de nivel de servidor
Estas reglas permiten a los clientes acceder a toda la instancia de Azure SQL Server (es decir, a todas las bases de datos que se encuentren en el mismo servidor lógico). Hay tres tipos de reglas que se pueden aplicar en el nivel de servidor.

- La regla Permitir el acceso a servicios de Azure permite a los servicios de Azure conectarse a la base de datos de Azure SQL Database. Cuando se activa, esta configuración permite las comunicaciones desde todas las direcciones IP públicas de Azure. Esto incluye todos los servicios de Plataforma de Azure como un servicio (PaaS), como Azure App Service y Azure Container Service, así como máquinas virtuales de Azure que tengan acceso de salida a Internet.

- Las reglas de dirección IP son reglas que se basan en intervalos de direcciones IP públicas específicas. Las direcciones IP que se conectan desde un intervalo IP público permitido tendrán permiso para conectarse a la base de datos. Estas reglas se pueden usar cuando tiene una dirección IP pública estática que necesita obtener acceso a la base de datos.

- Las reglas de red virtual le posibilitan permitir explícitamente la conexión de las subredes especificadas dentro de una o varias redes virtuales de Azure (VNET). Las reglas de red virtual pueden proporcionar un mayor control de acceso a las bases de datos y pueden ser la mejor opción en función del escenario. Las reglas de red virtual se usan si tiene máquinas virtuales de Azure que necesitan obtener acceso a la base de datos.

### Reglas de firewall de nivel de base de datos
permiten el acceso a una base de datos individual en un servidor lógico y se almacenan en la base de datos. Para las reglas de nivel de base de datos, solo pueden configurarse reglas de dirección IP. Estas funcionan del mismo modo que cuando se aplican en el nivel de servidor, pero tienen como ámbito únicamente la base de datos.

Las reglas de firewall de nivel de base de datos se pueden crear y manipular solo a través de Transact-SQL.

### Restricción del acceso de red en la práctica
Como procedimiento recomendado, usar reglas de firewall de IP de nivel de base de datos siempre que sea posible con el fin de mejorar la seguridad y aumentar la portabilidad de la base de datos.

Usar reglas de firewall de IP de nivel de servidor para administradores y cuando tenga varias bases de datos con los mismos requisitos de acceso y no quiera dedicar tiempo a configurar individualmente cada una de ellas.

Si se ejecuta lo siguiente para intentar conectarse saldra error ya que no hace acceso permitido a la BD
```
sqlcmd -S tcp:server16204.database.windows.net,1433 -d marketplaceDb -U admindevniel -P Devniel93##@@__ -N -l 30
```

### Usar la regla para permitir el acceso a servicios de Azure de nivel de servidor
1. En Azure Portal > seleccionar el recurso SQL Server creado
2. En Seguridad > seleccionar Firewalls y redes virtuales
3. Establecer Permitir el acceso a servicios de Azure en SÍ > Guardar.

### Usar una regla de dirección IP de nivel de base de datos
1. Para conceder acceso a una direccion IP estatica de la VM, se debe ejecutar comandos de T-SQL
```
EXECUTE sp_set_database_firewall_rule N'My Firewall Rule', '40.86.164.64', '40.86.164.64';
GO

EXIT
```
2. En Azure Portal > seleccionar el recurso SQL Server creado
3. En Seguridad > seleccionar Firewalls y redes virtuales
4. Establecer Permitir el acceso a servicios de Azure en NO > Guardar.
5. Probar conexion y se comprueba que aun hay conexion debido a que se configuro una regla de IP a nivel de base de datos.

### Use una regla de dirección IP de nivel de servidor
Permitir el acceso con una regla de nivel de servidor reduciría nuestros esfuerzos de administración, lo que se aplicará a todas las bases de datos en el servidor.
1. Estando en sqlcmd, Eliminar la regla de direccion IP a nivel de BD
```
EXECUTE sp_delete_database_firewall_rule N'My Firewall Rule';
GO

EXIT
```
2. En Azure Portal > Firewall y redes virtuales > agregar nueva regla "Allow appServer" con la ip inicio y fin de la IP publica del app server > Guardar
3. Conectarse para comprobar conexion

### Usar una regla de red virtual de nivel de servidor
Dado que la VM se ejecuta en Azure, podemos usar una regla de red virtual de nivel de servidor para aislar el acceso y facilitar la habilitación del acceso de servicios futuros a la base de datos.

1. En Azure Portal > Firewall y redes virtuales > Redes vrituales > seleccionar Agregar red virtual existente
2. Dejar los valores predeterminados > Habilitar > OK
3. Eliminar la regla "Allow appServer" 
4. Comprobar conexion. Lo que se hizo quita cualquier acceso público a SQL Server y solo permite el acceso desde la subred específica de la red virtual de Azure que hemos definido. Si tuviéramos que agregar servidores de aplicación adicionales en que la subred, no sería necesaria ninguna configuración adicional, ya que cualquier servidor en esa subred tendría la capacidad para conectarse a SQL server