Implementacion de workflows de comunicacion basados en mensajes con
Azure Service Bus

##########

Eleccion de una plataforma de mensajeria

Mensajes
- En la terminología de las aplicaciones distribuidas, la característica 
definitoria de un mensaje es que la integridad general de la aplicación 
puede depender de la recepción de mensajes. 
- Un mensaje contiene los propios datos, no solo una referencia a los 
datos (por ejemplo, una dirección URL o un identificador). El envío de 
datos como parte del datagrama es menos frágil que el envío de una 
referencia. La arquitectura de mensajería garantiza la entrega del 
mensaje.

Eventos
- Un evento desencadena la notificación de que ha sucedido algo. Los 
eventos son "más ligeros" que los mensajes.
- El evento puede enviarse a varios destinatarios o a ninguno.
- Suelen estar diseñados para la "distribución ramificada de salida" o 
para disponer de un número elevado de suscriptores para cada publicador.
- El publicador del evento no tiene ninguna expectativa sobre la acción 
que realiza un componente receptor.

Colas, Topics y Relays de Service Bus

¿Qué es una cola?
Es una ubicación de almacenamiento temporal simple para los mensajes. Un 
componente de envío agrega un mensaje a la cola. Un componente de destino 
selecciona el mensaje al comienzo de la cola. En circunstancias normales, 
un solo receptor recibe cada mensaje.

Durante las horas pico, se pueden recibir mensajes a una velocidad mayor de
la que los componentes de destino pueden controlar. Como los componentes de
origen no tienen ninguna conexión directa al destino, el origen no se verá
afectado y aumentará la cola. Los componentes de destino quitarán los 
mensajes de la cola a medida que sean capaces de controlarlos.

¿Qué es un topic?
Un topic es similar a una cola, pero puede tener varias suscripciones. Esto
significa que varios componentes de destino pueden suscribirse a un solo 
topic, para que cada mensaje se entregue a varios receptores

¿Qué es una relay?
- Un relay o retransmision es un objeto que establece una comunicación 
sincrónica bidireccional entre aplicaciones. A diferencia de las colas 
y los topics, no es una ubicación de almacenamiento temporal para los 
mensajes. 
- Proporciona conexiones bidireccionales sin almacenamiento en búfer en 
los límites de la red, como los firewalls

Service Bus Queues y Storage Queues
- Las colas de almacenamiento son más fáciles de usar, pero menos 
sofisticadas y flexibles que las colas de Service Bus.

Ventajas de las colas de Service Bus 
- Admite tamaños de mensajes superiores a 256 KB (nivel Estándar) o 
1 MB (nivel Premium) por mensaje frente a 64 KB.
- Se admite la entrega como máximo una vez y al menos una vez
- Se garantiza el orden primero en entrar, primero en salir (FIFO)
- En una transacción se pueden agrupar varios mensajes: si no se puede 
entregar un mensaje en la transacción, no se entregará ninguno de los 
mensajes en la transacción
- Se admite la seguridad basada en roles.
- No se requiere que los componentes de destino sondeen la cola de forma 
continua

Ventajas de las colas de almacenamiento:
- Se admite un tamaño de cola ilimitado (frente al límite de 80 GB de 
las colas de Service Bus).
- Se mantiene un registro de todos los mensajes

Cómo elegir una tecnología de comunicaciones
¿Es la comunicación un evento? Si es así, considere la posibilidad de 
usar Event Grid o Event Hubs.
¿Debería entregarse un único mensaje a más de un destino? Si es así, 
use un tema de Service Bus. De lo contrario, use una cola.

Elegir las colas de Service Bus si:
- Se necesita una garantía de entrega Como máximo una vez.
- Se necesita una garantía FIFO
- Se necesita agrupar los mensajes en transacciones.
- Se quiere recibir mensajes sin sondear la cola
- Se quiere proporcionar un acceso basado en roles a las colas.
- El tamaño de la cola no aumentará a más de 80 GB.


Elegir Azure Queue Storage si:
- Se necesita una cola simple sin requisitos adicionales determinados
- Se necesita un registro de auditoría de todos los mensajes que pasan 
por la cola.
- Se espera que la cola supere el tamaño de 80 GB.
- Se quiere realizar el seguimiento del progreso para procesar un mensaje 
dentro de la cola
