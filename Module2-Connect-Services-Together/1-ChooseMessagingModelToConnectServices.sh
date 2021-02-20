Si se planea trabajar sobre un arquitectura de una aplicacion distribuida,
se debe asegurar que la aplicacion sea confiuable y escable. Se debe 
conocer todas las comunicaciones entre los componentes de la aplicacion.
Hay que saber si en la comunicacion se envian mensajes o eventos.

¿Qué es un mensaje?
En la terminología de las aplicaciones distribuidas:
- Contiene datos sin procesar producidos por un componente y será consumido 
por otro componente
- El componente de envío espera a que el componente de destino procese el 
contenido del mensaje. La integridad del sistema puede depender de que el 
remitente y receptor realicen un trabajo específico.

¿Qué es un evento?
- Es una notificación ligera que indica que algo ha sucedido
- Los componentes que envían el evento se llaman publishers y los destinatarios 
se conocen como subscribers.
- Con los eventos, los componentes destinatarios, deciden qué comunicaciones 
les interesan y se suscriben a ellas. 
- La suscripción la administra un intermediario, como Azure Event Grid o 
Azure Event Hubs. Cuando los publicadores envían un evento, el intermediario 
enrutará ese evento a los suscriptores interesados. Este patrón se conoce como 
arquitectura "publish-subscribe"
- El evento puede enviarse a varios destinatarios o a ninguno.
- Suelen estar diseñados para la "distribución ramificada de salida" (fan out) 
o para disponer de un número elevado de suscriptores para cada publicador.
- Algunos eventos son unidades discretas y no están relacionados con 
otros eventos.
- Algunos eventos forman parte de una serie ordenada y relacionada.

Para elegir si es mensaje o evento, plantearse la pregunta:
¿el componente de envío espera que el componente de destino procese 
la comunicación de una forma determinada?
Si la respuesta es sí, optar por un mensaje. Si la respuesta es no, 
es posible que pueda utilizar los eventos.

#############
¿Qué es Azure Queue Storage?
Es un servicio que usa Azure Storage para almacenar grandes cantidades de 
mensajes a los que se puede acceder mediante REST. Las colas pueden contener 
millones de mensajes, limitados solamente por la capacidad de la cuenta 
de almacenamiento que las posea

¿Qué es Azure Service Bus Queues?
- Es un sistema de agente de mensajes destinado a aplicaciones empresariales. 
- Usan varios protocolos de comunicación, requisitos de seguridad más altos 
y pueden incluir servicios en la nube y locales.

Que son los Azure Service Bus Topics?
- Son similares a las colas, pero pueden tener varios suscriptores
- Cuando un mensaje se envía a un topic en lugar de a una cola, varios 
componentes se pueden desencadenar para hacer su trabajo.
- Internamente, los topics usan colas. Cuando se hace una publicación en un 
topic, el mensaje se copia y coloca en la cola correspondiente a cada 
suscripción

Ventajas de las colas
- Mayor confiabilidad: 
Las colas aumentan la confiabilidad del intercambio de mensajes porque, en 
los momentos de gran demanda, los mensajes pueden esperar a que un componente 
de destino esté listo para procesarlos.

- Garantías de entrega de mensajes:
Los sistemas de colas pueden garantizar la entrega del mensaje de la cola 
a un componente de destino. Hay 3 enfoques diferentes:
- At-Least-Once Delivery: garantiza la entrega de cada mensaje al menos a uno 
de los componentes que recuperan los mensajes de la cola, pero puede que el 
mismo mensaje se entregue mas de una vez.
- At-Most-Once Delivery: No se garantiza la entrega de cada mensaje, y hay 
pocas probabilidades de que no llegue. Pero no existe la posibilidad de que 
el mensaje se entregue dos veces
- First-In-First-Out (FIFO): Los mensajes dejan la cola en el mismo orden en 
que se agregaron

- Compatibilidad transaccional
Agrupación mensajes en una transacción. Las transacciones de mensajes se 
realizan correctamente o con errores como una sola unidad, como sucede con 
las bases de datos

¿Qué servicio elegir?

Usar Azure Service Bus Topics si:
- Necesita que varios receptores controlen cada mensaje.

Usar Azure Service Bus Queues si:
- Se necesita garantía de entrega Como máximo una vez, FIFO.
- Se necesita agrupar los mensajes en transacciones.
- Se necesita proporcionar un modelo de acceso basado en roles a las colas.
- Se necesita controlar mensajes mayores de 64 KB, pero menores de 256 KB.
- Si el tamaño de la cola no excederá los 80 GB.
- Si se desea publicar y consumir lotes de mensajes.

Usar Queue Storage si:
- Se necesita un registro de auditoría de todos los mensajes que pasan por 
la cola.
- Se espera que la cola supere el tamaño de 80 GB.
- Se quiere realizar el seguimiento del progreso para procesar un mensaje 
dentro de la cola.

##########

¿Qué es Azure Event Grid?
- Es un servicio de enrutamiento de eventos totalmente administrado que se 
ejecuta sobre Azure Service Fabric.
- Distribuye eventos desde diferentes orígenes, como cuentas de Azure 
Blob Storage o Azure Media Services, a diferentes controladores como Azure 
Functions o Webhooks.
- Proporciona un sistema de mensajería de bajo costo y escalable de forma 
dinámica que permite a los publicadores notificar a los suscriptores un 
cambio de estado

Los orígenes de eventos envían los eventos a Event Grid y este reenvía los 
que sean pertinentes a los suscriptores.
Los orígenes de eventos etiquetan cada evento con uno o varios topics, y 
los controladores de eventos se suscriben a los topics que les interesan.

¿Qué es un origen de eventos?
- Son responsables de enviar eventos a Event Grid. 
- Cada origen de evento está relacionado con uno o más tipos de eventos. 
- Por ejemplo, Azure Storage es el origen de evento de los eventos creados por 
blob. IoT Hub es el origen de evento de los eventos creados por dispositivo. 

¿Que es un event topic?
- Clasifican los eventos en grupos.
- Los topics se representan mediante un punto de conexión público y son el 
lugar a donde el origen del evento envía los eventos

Los topics se dividen en topics del sistema y topics personalizados:
- Topics del sistema: Son topics integrados que ofrecen los servicios de Azure
que no se puede ver pero si suscribir.
- Topics personalizados: Son topics de terceros y de aplicación. Se puede ver 
en la sucripcion de Azure

¿Qué es la suscripción a un evento?
- Definen qué eventos de un tema desea recibir un controlador de eventos. 
- Una suscripción puede filtrar eventos por su tipo o asunto, para 
asegurarse de que un controlador de eventos solo reciba los eventos pertinentes.
- 




