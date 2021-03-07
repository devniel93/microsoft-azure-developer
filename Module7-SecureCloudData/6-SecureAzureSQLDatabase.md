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

---

## _Control de quién puede acceder a la base de datos_
Aunque es posible que podamos conectarnos a la base de datos a través de la red, eso no significa que realmente podamos obtener acceso a los datos.

### Autenticación
Es el proceso de comprobación de una identidad. Esta identidad puede ser un usuario, un servicio que se ejecuta en un sistema o un sistema (por ejemplo, una máquina virtual). SQL Database admite dos tipos de autenticación: Autenticación de SQL y autenticación de Azure Active Directory.

#### Autenticación de SQL
Utiliza un nombre de usuario y una contraseña. Las cuentas de usuario se pueden crear en la base de datos maestra y se les puede conceder permisos en todas las bases de datos del servidor.

#### Autenticación con Azure Active Directory
Este método de autenticación usa las identidades administradas por Azure Active Directory (AD) y es compatible con dominios administrados e integrados. Si se desea usar la autenticación de AzureAD, debe crear otro administrador de servidor llamado "administrador de Azure AD" con permiso para administrar usuarios y grupos de Azure AD. 

### Autorización
Se refiere a lo que un usuario puede hacer en una Azure SQL Database. Esto se controla mediante los permisos concedidos directamente a la cuenta de usuario o a las pertenencias a roles de base de datos. Un rol de base de datos se usa para agrupar permisos conjuntamente para facilitar la administración, y se agrega un usuario a un rol para concederle los permisos que tiene el rol.

## _Autenticación y autorización puestas en práctica_
1. Creación de un usuario de base de datos
Conectarse a la BD desde la VM de appServer
```
sqlcmd -S tcp:server19870.database.windows.net,1433 -d marketplaceDb -U admindevniel -P Devniel93##@@__ -N -l 30
```

Crear el usuario. Este es un usuario de BD independiente y solo tiene acceso a la BD marketplace.
```
CREATE USER ApplicationUser WITH PASSWORD = 'YourStrongPassword1';
GO
```

2. Concesión de permisos a un usuario
Ejecutar lo siguiente para conceder los roles db_datareader y db_datawriter al usuario
```
ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
GO
```

Para denegar que el usuario ejecute select a la tabla SalesLT.Address
```
DENY SELECT ON SalesLT.Address TO ApplicationUser;
GO
```

3. Iniciar sesion con el usuario ApplicationUser
```
sqlcmd -S tcp:server19870.database.windows.net,1433 -d marketplaceDb -U 'ApplicationUser' -P 'YourStrongPassword1' -N -l 30
```
4. Comprobar permisos de acceso a datos del usuario 
Ejecutar select a una tabla con permisos
```
SELECT FirstName, LastName, EmailAddress, Phone FROM SalesLT.Customer;
GO
```

Ejecutar select a una tabla sin permisos . Este arrojara un resultado de error por pemiso denegado.
```
SELECT * FROM SalesLT.Address;
GO
```

---

## _Protección de los datos en tránsito, en reposo y en pantalla_
En la base de datos marketplaceDb se almacena información confidencial, como direcciones físicas, direcciones de correo electrónico y números de teléfono. Si se expone, atacantes malintencionados podrían usarla para dañar nuestro negocio o a nuestros clientes.

### Cifrado de red TLS
Azure SQL Database aplica cifrado de Seguridad de la capa de transporte (TLS) en todo momento para todas las conexiones, lo que garantiza que todos los datos se cifran "en tránsito" entre la base de datos y el cliente. El cifrado TLS es un estándar de protección del tráfico a través de Internet y en este caso garantiza la seguridad en el tráfico de red hacia y desde Azure SQL Database.

### Cifrado de datos transparente
Azure SQL Database protege los datos en reposo con cifrado de datos transparente (TDE). TDE realiza cifrado y descifrado de la base de datos en tiempo real, copias de seguridad asociadas y archivos de registro de transacciones en reposo sin necesidad de efectuar cambios en la aplicación. Mediante una clave de cifrado de base de datos, el cifrado de datos transparente realiza el cifrado de E/S en tiempo real y el descifrado de los datos en el nivel de página. Todas las páginas se descifran cuando se leen en la memoria y después se cifran antes de escribirse en el disco.

Para comprobar que el Cifrado de datos transparente este activo
1. En Azure Portal > seleccionar la BD marketplaceDb
2. En Seguridad > seleccionar Cifrado de datos transparente
3. Cifrado de datos en Activo

### Enmascaramiento dinámico de datos
Mediante el uso de la característica de enmascaramiento dinámico de datos de Azure SQL Database, podemos limitar los datos que se muestran al usuario. El enmascaramiento dinámico de datos es una característica de seguridad basada en directivas que oculta los datos confidenciales en el conjunto de resultados de una consulta sobre los campos designados de la base de datos, aunque los datos de la base de datos no cambian.

Las reglas de enmascaramiento de datos constan de información sobre la columna a la que se aplicará la máscara y cómo se deben enmascarar los datos. Se puede crear su propio formato de enmascaramiento, o usar una de las máscaras estándares.

Al consultar las columnas, los administradores de bases de datos siguen viendo los valores originales, pero los usuarios que no son administradores ven los valores enmascarados. Puede permitir que otros usuarios vean las versiones no enmascaradas si los incluye en los usuarios SQL excluidos de la lista de enmascaramiento.

1. En Azure Portal > seleccionar la BD marketplaceDb
2. En Seguridad > seleccionar Enmascaramiento dinamico de datos
En la pantalla Reglas de enmascaramiento se muestra una lista de las máscaras dinámicas de datos existentes y recomendaciones para las columnas a las que se debería aplicar un enmascaramiento dinámico de datos.
3. Seleccionar Agregar mascara > Agregar regla de enmascaramiento 
4. Ingresar los valores de esquema, tabla, columna, formato del campo de enmascaramiento, prefijo expuesto, cadena de relleno, sufijo expuesto
5. Guardar
6. Conectarse a la BD desde la VM appServer
7. Realizar select de las columnas y tabla y comprobar que estan enmascaradas
```
SELECT FirstName, LastName, EmailAddress, Phone FROM SalesLT.Customer;
GO
```