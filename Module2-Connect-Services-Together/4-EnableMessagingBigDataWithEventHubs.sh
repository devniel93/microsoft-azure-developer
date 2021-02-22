Habilitacoin de mensajeria confiable para aplicacion BigData con 
Azure Event Hubs

###########

¿Qué es un centro de eventos de Azure?
Es un servicio de procesamiento de eventos basado en la nube capaz de recibir 
y procesar millones de eventos por segundo. Event Hubs actúa como una puerta 
principal para una canalización de eventos, con el fin de recibir los datos 
entrantes y almacenarlos hasta que los recursos de procesamiento estén 
disponibles.

Eventos
- Es un pequeño paquete de información (un datagrama) que contiene una 
notificación. 
- Se pueden publicar de manera individual, o en lotes, pero una sola 
publicación (individual o en lote) no puede superar 1 MB.

Publicadores y suscriptores
- Los publicadores de eventos son cualquier aplicación o dispositivo que pueda 
enviar eventos mediante el protocolo HTTPS o Advanced Message Queuing 
Protocol (AMQP) 1.0.
- Para los publicadores que envían datos con frecuencia, AMQP tiene mejor 
rendimiento. Pero tiene una mayor sobrecarga de sesión inicial, ya que primero 
se debe configurar un socket bidireccional persistente y seguridad de nivel 
de transporte (TLS) o SSL/TLS.
- Para una publicación más intermitente, la mejor opción es HTTPS. Aunque HTTPS 
requiere sobrecarga adicional para cada solicitud, no se trata de la sobrecarga 
de inicialización de sesión.

Los suscriptores de eventos son aplicaciones que usan uno de los dos métodos 
de programación para recibir y procesar eventos de un event hubs:
- EventHubReceiver: método sencillo que proporciona opciones de administración 
limitadas.
- EventProcessorHost: método eficaz 

Grupos de consumidores
- Representa una vista específica del flujo de datos de un centro de eventos. 
- Mediante el uso de grupos de consumidores independientes, varias aplicaciones 
de suscriptor pueden procesar un flujo de eventos por separado y sin afectar a 
otras aplicaciones.

Precios
- Existen tres planes de tarifa para Azure Event Hubs: Básico, Estándar y Dedicado. 
- Los planes difieren en cuanto a las conexiones admitidas, el número de grupos 
de consumidores disponibles y el rendimiento. 
- Si no se especifica un plan de tarifa, se asigna el valor predeterminado de 
Estándar (20 grupos de consumidores, 1000 conexiones asincrónicas).

Creación y configuración de una instancia nueva de Azure Event Hubs
1. Definición de un namespace de Event Hubs
Es una entidad contenedora para administrar una o varias instancias de Event Hubs

2. Definir la configuracion del namespace

Seleccionar un nombre único para el espacio de nombres. Es posible acceder al 
espacio de nombres a través de esta dirección 
URL: espacio_de_nombres.servicebus.windows.net

Definir estas propiedades opcionales:
- Habilitar Kafka: Permite que las aplicaciones Kafka publiquen eventos en 
el event hubs.
- Hacer que esta zona de namespace sea redundante. La redundancia de zona 
replica datos entre centros de datos independientes con sus infraestructuras de 
alimentación, redes y refrigeración por separado.
- Habilitar inflado automático y Máximo de unidades de procesamiento de inflado 
automático. El inflado automático proporciona una opción de escalado horizontal 
automático al aumentar el número de unidades de procesamiento hasta un 
valor máximo.

Comandos de la CLI de Azure para crear un namespace:
az eventhubs namespace

Configuración de un nuevo Event Hubs

- Nombre del centro de eventos: nombre único dentro de la suscripción y debe 
tener  entre 1 y 50 caracteres. 
- Número de particiones: que se requieren en un centro de eventos (entre 2 y 32).
El número de particiones debe estar directamente relacionado con el número 
previsto de consumidores simultáneos y no se puede cambiar una vez creado. La 
partición separa el flujo de mensajes, de manera que las aplicaciones de 
consumidor o receptor solo deben leer un subconjunto específico del flujo de 
datos. Por default el valor es de 4.
- Retención de mensajes: número de días (entre 1 y 7) que los mensajes seguirán 
disponibles. Si no se define, el valor por default es de 7.

Comandos de la CLI de Azure para crear una instancia de Event Hubs:
az eventhubs eventhub

##############

Pasos para crear un Namespace y un EventHub 

1. Configurar los recursos locales con Azure CLI
az configure --defaults group=learn-2a9afa70-7bf4-4c31-8a43-c8b8969cc79b location=westus2

2. Crear un Namespace
NS_NAME=ehubns-$RANDOM
az eventhubs namespace create --name $NS_NAME

3. Obtener cadena de conexion
az eventhubs namespace authorization-rule keys list \
    --name RootManageSharedAccessKey \
    --namespace-name $NS_NAME

$PRIMARY_CONNECTION_STRING
$PRIMARY_KEY

4. Crear EventHub

HUB_NAME=hubname-$RANDOM
az eventhubs eventhub create --name $HUB_NAME --namespace-name $NS_NAME

Para mostrar los detalles del Event Hub creado
az eventhubs eventhub show --namespace-name $NS_NAME --name $HUB_NAME

##########

Configuración de aplicaciones para enviar o recibir mensajes mediante un 
Event Hub

¿Cuáles son los requisitos mínimos para la aplicación del centro de eventos?

Para configurar una aplicación para enviar mensajes a un Event Hub, debe 
proporcionar la información siguiente:
- El nombre del namespace para el Event Hub
- Nombre del Event Hub
- El nombre de la directiva de acceso compartido
- La clave principal de acceso compartido

Para configurar una aplicación para recibir mensajes de un Event Hub, debe
proporcionar la información siguiente:
- El nombre del namespace para el Event Hub
- Nombre del Event Hub
- El nombre de la directiva de acceso compartido
- La clave principal de acceso compartido
- El nombre de la cuenta de almacenamiento
- La cadena de conexión de la cuenta de almacenamiento
- El nombre del contenedor de la cuenta de almacenamiento

Si se tiene una aplicación receptora que almacena mensajes en Azure Blob Storage,
también deberá configurar una cuenta de almacenamiento.

Comandos Azure CLI para crear una cuenta de almacenamiento Estándar de uso 
general

- Para crear una cuenta de almacenamiento de uso general V2.
storage account create	

- Para recuperar la clave de la cuenta de almacenamiento.
storage account key list	

- Para recuperar la cadena de conexión de una cuenta de Azure Storage.
storage account show-connection-string	

- Para crear un contenedor en una cuenta de almacenamiento.
storage container create	

##########

Pasos para configurar aplicaciones de envio y recepcion de mensajes 
mediante un Event Hub

1. Crear un storage account estandar de uso general

STORAGE_NAME=storagename$RANDOM
az storage account create --name $STORAGE_NAME --sku Standard_RAGRS --encryption-service blob

2. Obtener cadenas de conexion del storage account
az storage account keys list --account-name $STORAGE_NAME
$KEY1_STG
$KEY2_STG

az storage account show-connection-string -n $STORAGE_NAME
$STG_CONNECTION_STRING

3. Crear contenedor en el storage account
az storage container create --name messages --connection-string "$STG_CONNECTION_STRING"

4. Clonar repo de ejemplo con las aplicaciones de envio y recepcion
git clone https://github.com/Azure/azure-event-hubs.git

5. Editar las cadenas de conexion en 
cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend

final ConnectionStringBuilder connStr = new ConnectionStringBuilder()
                .setNamespaceName("ehubns-16009") // to target National clouds - use .setEndpoint(URI)
                .setEventHubName("hubname-11926")
                .setSasKeyName("RootManageSharedAccessKey")
                .setSasKey("...");

6. Compilar aplicacion maven java
cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
mvn clean package -DskipTests

7. Editar las cadenas de conexion en 
cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample/src/main/java/com/microsoft/azure/eventhubs/samples/eventprocessorsample
String consumerGroupName = "$Default";
    	String namespaceName = "ehubns-16009";
    	String eventHubName = "hubname-11926";
    	String sasKeyName = "RootManageSharedAccessKey";
    	String sasKey = "FiKc...";
    	String storageConnectionString = "DefaultEndpointsProtocol...";
    	String storageContainerName = "messages";
    	String hostNamePrefix = "storagename7480";

8. Compilar aplicacion maven java
cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
mvn clean package -DskipTests

9. Ejecutar las aplicacion de envio al Event Hub
cd ~/azure-event-hubs/samples/Java/Basic/SimpleSend
java -jar ./target/simplesend-1.0.0-jar-with-dependencies.jar

10. Ejecuta la aplicacion de recepcion de mensajes
cd ~/azure-event-hubs/samples/Java/Basic/EventProcessorSample
java -jar ./target/eventprocessorsample-1.0.0-jar-with-dependencies.jar

########

Evaluación del rendimiento del Event Hub implementado 
mediante Azure Portal

En Azure Portal > Información general del Event Hubs se muestran los 
recuentos de mensajes. Estos recuentos de mensajes representan los datos 
(eventos) recibidos y enviados por Event Hub.

Otras métricas útiles disponibles en Event Hubs incluyen las siguientes:
- Solicitudes limitadas: número de solicitudes limitadas debido a que el 
rendimiento ha superado el uso de la unidad.
- ActiveConnections: número de conexiones activas en un namespace o 
Event Hub.
- Bytes entrantes/salientes: número de bytes enviados y recibidos mediante el 
servicio Event Hubs durante un período especificado.
