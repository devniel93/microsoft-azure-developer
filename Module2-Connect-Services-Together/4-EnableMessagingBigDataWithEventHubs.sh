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

