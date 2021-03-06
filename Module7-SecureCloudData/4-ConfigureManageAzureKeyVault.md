# Configuración y administración de secretos en Azure Key Vault
Azure Key Vault ayuda a proteger las claves criptográficas y los secretos que usan los servicios y aplicaciones en la nube. Key Vault agiliza el proceso de administración de claves y le permite mantener el control de claves que obtienen acceso a sus datos y los cifran.

## _Instrucciones para configurar Azure Key Vault_
En una instancia de Azure Key Vault se usan tres conceptos principales: almacenes, claves y secretos.

### Almacenes
Azure Key Vault se usa para crear múltiples contenedores seguros denominados almacenes. Los almacenes ayudan a reducir las posibilidades de que se produzca una pérdida accidental de información de seguridad mediante la centralización del almacenamiento de los secretos de aplicación. Cada almacén de claves es una colección de claves criptográficas y datos protegidos criptográficamente (denominados "secretos").

Para crear un almacen de grupos con Azure CLI:
```
az keyvault create \
    --resource-group <resource-group> \
    --name <your-unique-vault-name>
```

Para crear un almacen de grupos con Azure PowerShell:
```
New-AzKeyVault -Name <your-unique-vault-name> -ResourceGroupName <resource-group>
```

### Claves
Las claves son el actor central en el servicio Azure Key Vault. Una clave determinada en un almacén de claves es un recurso criptográfico destinado a un uso concreto.

Microsoft y las aplicaciones no tienen acceso a las claves almacenadas directamente. Las aplicaciones deben usar las claves mediante la llamada a métodos de criptografía en el servicio Key Vault.

Las claves pueden ser de una sola instancia (solo existe una clave) o tener versiones. En el caso de las versiones, una clave es un objeto con una clave principal (activa) y una colección de una o varias claves secundarias (archivadas) creadas cuando se revierten las claves (se renuevan). Key Vault admite las claves asimétricas (RSA 2048). 

Existen dos variantes de claves de Key Vault: con protección por hardware y con protección por software.

#### Claves protegidas por hardware
El servicio Key Vault admite el uso de HSM que proporcionan un entorno protegido y resistente a manipulaciones para el procesamiento criptográfico y la generación de claves. Azure tiene HSM dedicados validados en nivel 2 de FIPS 140-2 que Key Vault usa para generar o almacenar claves. 

#### Claves protegidas por software
Key Vault también puede generar y proteger claves mediante algoritmos RSA y ECC basados en software. Por lo general, las claves protegidas por software ofrecen la mayoría de las características que las protegidas con HSM, excepto la garantía del nivel 2 de FIPS 140-2:
- La clave sigue aislada de la aplicación (y Microsoft) en un contenedor que administra personalmente.
- Se almacena en reposo cifrado mediante HSM
- Puede supervisar el uso mediante registros de Key Vault

La principal diferencia (además del precio) con respecto a una clave protegida con software es que las operaciones criptográficas se realizan en software mediante servicios de proceso de Azure, mientras que, para las claves protegidas con HSM, se realizan dentro del HSM.

El tipo de generación de la clave se determina al crearla:
```
$key = Add-AzureKeyVaultKey -VaultName 'contoso' -Name 'MyFirstKey' -Destination 'HSM'
```

### Secretos
Son pequeños blobs de datos (menos de 10K) protegidos por una clave generada por HSM creada con el almacén de claves. Los secretos permiten simplificar el proceso de persistencia de valores confidenciales que casi todas las aplicaciones tienen: claves de cuenta de almacenamiento, archivos .PFX, cadenas de conexión SQL, claves de cifrado de datos, etc.

## _Uso del almacén de claves_
Una instancia de Azure Key Vault ayuda a solucionar los problemas siguientes:

- Administración de secretos. Azure Key Vault puede almacenar de forma segura (mediante HSM) y controlar estrechamente el acceso a tokens, contraseñas, certificados, claves de API y otros secretos.
- Administración de claves. Azure Key Vault es una solución de administración de claves basada en la nube, que facilita la creación y el control de las claves de cifrado que se usan para cifrar los datos. 
- Administración de certificados. Azure Key Vault también es un servicio que permite aprovisionar, administrar e implementar fácilmente certificados SSL y TLS públicos y privados para su uso con Azure y los recursos internos conectados. 

## _Procedimientos recomendados_

- Para conceder acceso a usuarios, grupos y aplicaciones en un ámbito concreto:
Usar los roles predefinidos de RBAC.

- Para controlar a qué tienen acceso los usuarios:
El acceso a un almacén de claves se controla a través de dos interfaces independientes: plano de administración y plano de datos. Los controles de acceso del plano de administración y del plano de datos funcionan de forma independiente. Usar RBAC para controlar a qué tienen acceso los usuarios. 

- Para almacenar los certificados en el almacén de claves:
Azure Resource Manager puede implementar de manera segura los certificados almacenados en Azure Key Vault para las máquinas virtuales de Azure cuando estas se implementan.

- Para recuperar almacenes de claves u objetos de almacén de claves si se eliminan:
La eliminación de almacenes de claves u objetos de almacén de claves puede ser involuntaria o malintencionada. Habilitar las características de protección de purga y eliminación temporal de Key Vault, especialmente para las claves que se usan para cifrar datos en reposo. 

--- 

## _Administración del acceso a secretos, certificados y claves_
Al acceso de Key Vault tiene dos aspectos: la administración del propio almacén de claves y el acceso a los datos que contiene. En la documentación se hace referencia a estos aspectos como el plano de administración y el plano de datos.

Para acceder a un almacén de claves, todos los usuarios o aplicaciones deben tener la autenticación correcta para identificar al autor de la llamada y autorización para determinar las operaciones que puede realizar el autor de la llamada.

### Authentication
Azure Key Vault usa Azure Active Directory (Azure AD) para autenticar los usuarios y las aplicaciones que intentan acceder a un almacén. 

### Autorización
Las operaciones de administración (la creación de una instancia de Azure Key Vault) usan el control de acceso basado en rol (RBAC). Existe un rol integrado de Colaborador de almacén de claves que proporciona acceso a las características de administración de los almacenes de claves, pero no permite el acceso a los datos del almacén de claves. Es el rol que se recomienda usar. También hay un rol de Colaborador que incluye derechos de administración completos, incluida la capacidad de conceder acceso al plano de datos.

En las operaciones de lectura y escritura de datos en el almacén de claves se usa una directiva de acceso de Key Vault, el cual sirve para dar permisos a un usuario para leer, escribir o eliminar secretos y claves. Puede crear una directiva de acceso mediante la CLI, la API REST o Azure Portal.

Los desarrolladores solo necesitarán los permisos Get y List para un almacén de entorno de desarrollo. Un desarrollador principal o jefe necesitará permisos completos para el almacén para cambiar y agregar secretos cuando sea necesario. Los permisos completos para los almacenes del entorno de producción se reservan normalmente para el personal de operaciones superior. En el caso de las aplicaciones, a menudo solo necesitan permisos Get, ya que solo tendrán que recuperar secretos.

## _Restricción del acceso de red_
Se debe tener en cuenta con Azure Key Vault es qué servicios de la red pueden acceder al almacén. Se debe determinar el acceso de red mínimo necesario; por ejemplo, puede restringir los puntos de conexión de Key Vault a subredes específicas de Azure Virtual Network, a direcciones IP concretas o a servicios de Microsoft de confianza, como Azure SQL, Azure App Service y distintos servicios de datos y almacenamiento en los que se usen claves de cifrado.