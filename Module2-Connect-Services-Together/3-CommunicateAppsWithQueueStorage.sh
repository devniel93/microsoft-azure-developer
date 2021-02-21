Comunicación entre aplicaciones con Azure Queue Storage
############################

Qué es Azure Queue Storage?
Es un servicio de Azure que implementa colas basadas en la nube. Cada cola 
mantiene una lista de mensajes. Los componentes de la aplicación tienen 
acceso a una cola mediante API REST o una biblioteca de cliente 
proporcionada por Azure. Normalmente, tendrá uno o varios componentes 
de remitente y uno o varios componentes de receptor. 

¿Por qué conviene usar colas?
- Una cola aumenta la resistencia mediante el almacenamiento temporal de 
mensajes de espera. En ocasiones de demanda baja o normal, el tamaño de 
la cola permanece reducido, ya que el componente de destino quita los 
mensajes de la cola con mayor rapidez con la que se agregan. En los 
momentos de gran demanda, la cola puede aumentar de tamaño, pero los 
mensajes no se pierden.
- Las colas permiten que la aplicación se escale de forma automática e 
inmediata cuando cambie la demanda.
- El escalado automático responde a la demanda con rapidez, pero no al 
instante. Por el contrario, Azure Queue Storage controla instantáneamente 
la alta demanda almacenando los mensajes hasta que estén disponibles los 
recursos de procesamiento.

¿Qué es un mensaje?
- Un mensaje en una cola es una matriz de bytes de hasta 64 KB. 
- Para un mensaje estructurado, puede dar formato al contenido del mensaje 
con XML o JSON. El código es responsable de generar e interpretar el 
formato personalizado

Creación de una cuenta de almacenamiento
- Una cola debe formar parte de una cuenta de almacenamiento. 

Configuración de colas
- Las colas solo están disponibles como parte de las cuentas de 
almacenamiento de uso general (v1 o v2). No se puede agregar a las 
cuentas de almacenamiento de blobs.
- El valor del nivel de acceso que se muestra para las cuentas de 
StorageV2 se aplica solo al almacenamiento de blobs y no afecta a las 
colas.
- Debe elegir una ubicación cercana a los componentes de origen o de 
destino, o (preferiblemente) ambos.
- Los datos siempre se replican en varios servidores para protegerse 
contra errores de disco y otros problemas de hardware. Tiene varias 
estrategias de replicación donde elegir: el almacenamiento con redundancia 
local (LRS) tiene un bajo coste, pero es vulnerable ante los desastres 
que afecten a un centro de datos completo, y el almacenamiento con 
redundancia geográfica (GRS) replica los datos en otros centros de 
datos de Azure.
- El nivel de rendimiento determina cómo se almacenan los mensajes: en 
Estándar se utilizan unidades de disco duro y en Premium se utilizan 
unidades de estado sólido. 
- Requiera una transferencia segura si es posible que se pase información 
confidencial a través de la cola. Esta configuración garantiza que todas 
las conexiones a la cola se cifran mediante la Capa de sockets 
seguros (SSL).

Para crear un Storage Account por Azure CLI

Ejecutar
az storage account create --name [unique-name] -g learn-c76a479f-113b-405d-9344-c20569ee167e --kind StorageV2 --sku Standard_LRS

#########

Identificaciond e una cola
- Cada cola tiene un nombre que se asigna durante la creación
- El nombre debe ser único dentro de la cuenta de almacenamiento, pero no 
tiene que ser único de forma global 
- La combinación del nombre de su cuenta de almacenamiento y el 
nombre de la cola identifica una cola.

Autorización de acceso
- Azure Active Directory:
Puede usar la autenticación basada en roles e identificar clientes 
específicos en función de las credenciales de AAD.
- Clave compartida: 
A veces se denomina clave de cuenta y se trata de 
una firma de clave cifrada asociada con la cuenta de almacenamiento. Cada 
cuenta de almacenamiento tiene dos de estas claves que se pueden pasar 
con cada solicitud para autenticar el acceso. Usar este enfoque es similar 
a utilizar una contraseña raíz: proporciona acceso total a la cuenta de 
almacenamiento.
- Firma de acceso compartido:	
Una firma de acceso compartido (SAS) es un URI generado que concede acceso
limitado a los objetos de la cuenta de almacenamiento a los clientes. 
Puede restringir el acceso a recursos, permisos y un ámbito en concreto a 
un intervalo de datos para desactivar automáticamente el acceso tras un 
período de tiempo.


Para obtener la clave de acceso del Storage Account
- Por Azure CLI
az storage account keys list ...

- Por Powershell
Get-AzStorageAccountKey ...

Acceder a las colas
Se accede a una cola mediante una API REST. 
Por ejemplo: http://<storage account>.queue.core.windows.net/<queue name>. 
Debe incluirse un encabezado Authorization con cada solicitud.

Usar la biblioteca cliente de Azure Storage para .NET
- Es una biblioteca que proporciona Microsoft y que formula solicitudes REST 
y analiza las respuestas REST
- La biblioteca cliente usa una cadena de conexión para establecer la 
conexión. La cadena de conexión está disponible en la sección Configuración 
de la cuenta de almacenamiento en Azure Portal, o bien mediante la CLI de 
Azure y PowerShell.
- Ejemplo:
string connectionString = "DefaultEndpointsProtocol=https;AccountName=<your storage account name>;AccountKey=<your key>;EndpointSuffix=core.windows.net"

