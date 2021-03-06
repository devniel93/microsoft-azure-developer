# Implementacion de workflows de comunicacion basados en mensajes con Azure Service Bus

## _Eleccion de una plataforma de mensajeria_

### Mensajes
- En la terminología de las aplicaciones distribuidas, la característica definitoria de un mensaje es que la integridad general de la aplicación puede depender de la recepción de mensajes. 
- Un mensaje contiene los propios datos, no solo una referencia a los datos (por ejemplo, una dirección URL o un identificador). El envío de datos como parte del datagrama es menos frágil que el envío de una referencia. La arquitectura de mensajería garantiza la entrega del mensaje.

### Eventos
- Un evento desencadena la notificación de que ha sucedido algo. Los eventos son "más ligeros" que los mensajes.
- El evento puede enviarse a varios destinatarios o a ninguno.
- Suelen estar diseñados para la "distribución ramificada de salida" o para disponer de un número elevado de suscriptores para cada publicador.
- El publicador del evento no tiene ninguna expectativa sobre la acción que realiza un componente receptor.

## _Colas, Topics y Relays de Service Bus_

### ¿Qué es una cola?
Es una ubicación de almacenamiento temporal simple para los mensajes. Un componente de envío agrega un mensaje a la cola. Un componente de destino selecciona el mensaje al comienzo de la cola. En circunstancias normales, un solo receptor recibe cada mensaje.

Durante las horas pico, se pueden recibir mensajes a una velocidad mayor de la que los componentes de destino pueden controlar. Como los componentes de origen no tienen ninguna conexión directa al destino, el origen no se verá afectado y aumentará la cola. Los componentes de destino quitarán los mensajes de la cola a medida que sean capaces de controlarlos.

### ¿Qué es un topic?
Un topic es similar a una cola, pero puede tener varias suscripciones. Esto significa que varios componentes de destino pueden suscribirse a un solo topic, para que cada mensaje se entregue a varios receptores.

### ¿Qué es una relay?
- Un relay o retransmision es un objeto que establece una comunicación sincrónica bidireccional entre aplicaciones. A diferencia de las colas y los topics, no es una ubicación de almacenamiento temporal para los mensajes. 
- Proporciona conexiones bidireccionales sin almacenamiento en búfer en los límites de la red, como los firewalls.

### Service Bus Queues y Storage Queues
Los Storage Queues son más fáciles de usar, pero menos sofisticadas y flexibles que las colas de Service Bus.

### Ventajas de Service Bus Queues
- Admite tamaños de mensajes superiores a 256 KB (nivel Estándar) o 1 MB (nivel Premium) por mensaje frente a 64 KB.
- Se admite la entrega como máximo una vez y al menos una vez
- Se garantiza el orden primero en entrar, primero en salir (FIFO)
- En una transacción se pueden agrupar varios mensajes: si no se puede entregar un mensaje en la transacción, no se entregará ninguno de los mensajes en la transacción.
- Se admite la seguridad basada en roles.
- No se requiere que los componentes de destino sondeen la cola de forma continua.

### Ventajas de Storage Queues:
- Se admite un tamaño de cola ilimitado (frente al límite de 80 GB de las colas de Service Bus).
- Se mantiene un registro de todos los mensajes.

### Cómo elegir una tecnología de comunicaciones
¿Es la comunicación un evento? Si es así, considerar la posibilidad de usar Event Grid o Event Hubs.
¿Debería entregarse un único mensaje a más de un destino? Si es así, use un topic de Service Bus. De lo contrario, usar una cola.

Elegir Service Bus Queues si:
- Se necesita una garantía de entrega Como máximo una vez.
- Se necesita una garantía FIFO
- Se necesita agrupar los mensajes en transacciones.
- Se quiere recibir mensajes sin sondear la cola.
- Se quiere proporcionar un acceso basado en roles a las colas.
- El tamaño de la cola no aumentará a más de 80 GB.

Elegir Azure Queue Storage si:
- Se necesita una cola simple sin requisitos adicionales determinados.
- Se necesita un registro de auditoría de todos los mensajes que pasan por la cola.
- Se espera que la cola supere el tamaño de 80 GB.
- Se quiere realizar el seguimiento del progreso para procesar un mensaje dentro de la cola.

---

## _Escritura de código que usa las colas de Service Bus_
El paquete Microsoft.Azure.ServiceBus de NuGet facilita la escritura del código que se encarga de enviar y recibir mensajes a través de Service Bus, Microsoft proporciona una biblioteca de clases .NET `Microsoft.Azure.ServiceBus.`

La clase más importante de esta biblioteca de colas es la clase `QueueClient`.

### Cadenas y claves de conexión
Los componentes de origen y los de destino necesitan dos fragmentos de información para conectarse a una cola:
- La ubicación del espacio de nombres de Service Bus, también conocida como punto de conexión. Por ejemplo: pizzaService.servicebus.windows.net.
- Una clave de acceso. Service Bus restringe el acceso a colas, temas y retransmisiones al requerir una clave de acceso.

### Llamar a los métodos de forma asincrónica
La biblioteca cliente de Service Bus pone a disposición métodos async para interactuar con las colas para evitar que un subproceso se bloquee mientras se espera que las llamadas se completen. Usar el método `QueueClient.SendAsync()` con la palabra clave `await`.

1. Usar lo siguienete siempre que se llame una cola de Service Bus:
```
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure.ServiceBus;
```

- Crear un objeto `QueueClient`, pasarle la cadena de conexión, el nombre de la cola y enviar el mensaje en `UTF8`
```
queueClient = new QueueClient(TextAppConnectionString, "PrivateMessageQueue");
string message = "Sure would like a large pepperoni!";
var encodedMessage = new Message(Encoding.UTF8.GetBytes(message));
await queueClient.SendAsync(encodedMessage);
```

### Recepción de mensajes de la cola
- Para recibir mensajes, primero debe registrar un controlador de mensaje
```
queueClient.RegisterMessageHandler(MessageHandler, messageHandlerOptions);
```

- Realizar las tareas de procesamiento. Después, en el controlador de mensajes, llamar al método `QueueClient.CompleteAsync()` para quitar el mensaje de la cola:
```
await queueClient.CompleteAsync(message.SystemProperties.LockToken);
```

--- 

### Pasos para implementar en Azure Services Bus con Colas 

1. Clonar proyecto base 
git clone https://github.com/MicrosoftDocs/mslearn-connect-services-together.git

2. Obtener cadena de conexion
az servicebus namespace authorization-rule keys list \
    --resource-group learn-d7269f0d-25ae-4c34-9cf0-e0e6e54d37bb \
    --name RootManageSharedAccessKey \
    --query primaryConnectionString \
    --output tsv \
    --namespace-name salesteamapp-devniel93

Endpoint=sb://salesteamapp-devniel93.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=EObydpjOfCI3GeebP78D6OwOlAW8/6GzsVhkFK9PtfY=

3. Editar la cadena de conexion en `privatemessagesender/Program.cs` y en `privatemessagereceiver/Program.cs`

```
const string ServiceBusConnectionString = "";
```

4. Editar `privatemessagesender/Program.cs`

Para crear una cliente de cola:
```
queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
```

Para crear y dar formato a un mensaje para la cola:
```
string messageBody = $"$10,000 order for bicycle parts from retailer Adventure Works.";
var message = new Message(Encoding.UTF8.GetBytes(messageBody));
Console.WriteLine($"Sending message: {messageBody}");
```

Para enviar el mensaje a la cola:
```
await queueClient.SendAsync(message);
```

Para cerral la conexion a Service Bus:
```
await queueClient.CloseAsync();
```

5. Enviar mensaje a la cola. Ejecutar:
```
dotnet run -p privatemessagesender
```

Para obtener cuantos mensajes hay en la cola:
```
az servicebus queue show \
    --resource-group learn-d7269f0d-25ae-4c34-9cf0-e0e6e54d37bb \
    --name salesmessages \
    --query messageCount \
    --namespace-name <namespace-name>
```    

6. Editar `privatemessagereceiver/Program.cs`

Para crear un cliente de cola
```
queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
```

Para configurar las opciones de control de mensajes:
```
var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
{
    MaxConcurrentCalls = 1,
    AutoComplete = false
};
```

Para registrar el controlador de mensajes:
```
queueClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
```

Para mostrar los mensajes entrantes en la cola, en el metodo `ProcessMessageAsync()` editar:
```
Console.WriteLine($"Received message: SequenceNumber:{message.SystemProperties.SequenceNumber} Body:{Encoding.UTF8.GetString(message.Body)}");
```

Para quitar el mensaje recibido de la cola:
```
await queueClient.CompleteAsync(message.SystemProperties.LockToken);
```

Para cerrar la conexion:
```
await queueClient.CloseAsync();
```

7. Recuperar un mensaje de la cola. Ejecutar:
```
dotnet run -p privatemessagereceiver
```

Ejecutar para ver cuantos mensajes quedan en la cola. Deberian haber 0.
```
az servicebus queue show \
    --resource-group learn-d7269f0d-25ae-4c34-9cf0-e0e6e54d37bb \
    --name salesmessages \
    --query messageCount \
    --namespace-name <namespace-name>
```

---

### Escritura de codigo que usa Topics de Service Bus
Si se quiere que todos los mensajes enviados se entreguen a todos los componentes suscritos, tendrá que usar topics. 

### Escribir código que usa topics es una forma de reemplazar a las colas. 
Se debe utilizar el mismo paquete NuGet `Microsoft.Azure.ServiceBus`, configurar las cadenas de conexión y usar patrones de programación asincrónica.
Pero en este caso se debe usar la clase `TopicClient` en lugar de `QueueClient` para enviar mensajes y la clase `SubscriptionClient` para recibirlos.

Establecimiento de filtros en las suscripciones. Los filtros pueden ser de tres tipos:
- Boolean Filters:
TrueFilter garantiza que todos los mensajes enviados al topic se entreguen a la suscripción actual. FalseFilter garantiza que ninguno de los mensajes enviados se entregue a la suscripción actual

- SQL Filters:
Especifica una condición con la misma sintaxis que una cláusula `WHERE` en una consulta SQL. Solo los mensajes que devuelven True, se entregarán a los suscriptores. Los filtros SQL son los más flexibles, aunque también los más costosos, y podrían ralentizar el rendimiento de Service Bus.

- Correlation Filters:
Contiene un conjunto de condiciones que se comparan con las propiedades de cada mensaje. Si la propiedad del filtro y la propiedad del mensaje tienen el mismo valor, se considera una coincidencia.

---

### Pasos para implementar en Azure Services Bus con Topics

1. Editar `performancemessagesender/Program.cs`

Para crear uun cliente de topic:
```
topicClient = new TopicClient(ServiceBusConnectionString, TopicName);
```

Para crear y dar formato a un mensaje para la cola:
```
string messageBody = $"Total sales for Brazil in August: $13m.";
var message = new Message(Encoding.UTF8.GetBytes(messageBody));
Console.WriteLine($"Sending message: {messageBody}");
```

Para enviar mensjae a la cola:
```
await topicClient.SendAsync(message);
```

Para cerrar la conexion a Service Bus:
```
await topicClient.CloseAsync();
```

2. Enviar mensaje al topic. Ejecutar:
```
dotnet run -p performancemessagesender
```

Para obtener cuantos mensajes hay en el topic:
```
az servicebus topic subscription show \
    --resource-group learn-d7269f0d-25ae-4c34-9cf0-e0e6e54d37bb \
    --namespace-name salesteamapp-devniel93 \
    --topic-name salesperformancemessages \
    --name Americas \
    --query messageCount
```    

3. Editar `performancemessagereceiver/Program.cs`

Para crear un cliente de suscripcion:
```
subscriptionClient = new SubscriptionClient(ServiceBusConnectionString, TopicName, SubscriptionName);
```

Para configurar opciones del control de mensajes
```
var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
{
    MaxConcurrentCalls = 1,
    AutoComplete = false
};
```

Para registrar el controlador de mensajes
```
subscriptionClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
```

Para mostrar los mensajes entrantes:
```
Console.WriteLine($"Received sale performance message: SequenceNumber:{message.SystemProperties.SequenceNumber} Body:{Encoding.UTF8.GetString(message.Body)}");
```

Para quitar el mensaje recibido de la suscripcion
```
await subscriptionClient.CompleteAsync(message.SystemProperties.LockToken);
```

Para cerrarla conexion a Service Bus
```
await subscriptionClient.CloseAsync();
```

4. Recuperar un mensjae de una suscripcion de topic. Ejecutar:
```
dotnet run -p performancemessagereceiver
```

Ejecutar para ver cuantos mensajes quedan en la suscripcion del topic. Deberian haber 0
```
az servicebus topic subscription show \
    --resource-group learn-d7269f0d-25ae-4c34-9cf0-e0e6e54d37bb \
    --namespace-name <namespace-name> \
    --topic-name salesperformancemessages \
    --name Americas \
    --query messageCount
```