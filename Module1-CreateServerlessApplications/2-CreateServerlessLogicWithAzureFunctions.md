# ¿Qué es la informática sin servidor? - SERVERLESS COMPUTE
- La informática sin servidor se puede considerar una función como servicio (FaaS), o bien un microservicio que se hospeda en una plataforma de nube. 
- La lógica de negocios se ejecuta como funciones y no necesita aprovisionar ni escalar manualmente la infraestructura. 
- La aplicación se escala horizontalmente o se reduce verticalmente de manera automática en función de la carga. 
- Los dos métodos más comunes son Azure Logic Apps y Azure Functions.

## _¿Qué es Azure Functions?_
Es una plataforma de aplicaciones sin servidor. Permite que los desarrolladores hospeden la lógica de negocios que se puede ejecutar sin aprovisionar 
infraestructura. Proporciona escalabilidad intrínseca y solo se cobra por los recursos usados.

### Logica sin estado - STATELESS
Excelentes candidatos para el proceso sin servidor; las instancias de funciones se crean y destruyen a petición.

### Controladas por eventos - EVENT DRIVEN
Las funciones se basan en eventos. Esto significa que solo se ejecutan en respuesta a un evento (denominado "desencadenador" - TRIGGER), como recibir una solicitud HTTP o agregar un mensaje a una cola.

## _Ventajas de SERVERLESS_
- Escribir la lógica de negocios en el lenguaje que prefiera.
- El escalado se realizará automáticamente, no tendrá servidores que administrar y solo se le cobrará por lo que use.

## _Desventajas de SERVERLESS_
- Tiempo de ejecucion: 
Por default las funciones tienen un tiempo de espera de 5 minutos. Se puede configurar a un máximo de 10 minutos. Si la función necesita más de 10 minutos para ejecutarse, puede hospedarla en una máquina virtual. Si el servicio se inicia con una solicitud HTTP y espera ese valor como una respuesta HTTP, el tiempo de espera se restringe a 2.5 minutos, aunque se puede usar Durable Functions para orquestar varias funciones sin tiempo de espera.

- Frecuencia de ejecucion: 
Si espera que varios clientes ejecuten la función de manera continua, sería recomendable calcular el uso y el costo de usar las funciones en consecuencia. 
Podría ser más barato hospedar el servicio en una VM. Durante el escalado, solo se puede crear una instancia de aplicación de función cada 10 segundos, para hasta 200 instancias en total. Cada instancia puede atender varias ejecuciones simultáneas, por lo que no hay ningún límite establecido en la cantidad de tráfico que una sola instancia puede controlar.

## _¿Qué es una aplicación de función - FUNCTION APP?_
Las funciones se hospedan en un contexto de ejecución que se conoce como una aplicación de función. Puede definir aplicaciones de función para agrupar y estructurar de manera lógica las funciones y un recurso informático en Azure.

### Planes de servicio
- Plan de servicio de consumo: 
Cuando se usa la plataforma de SERVERLESS de Azure. Proporciona escalado automático y se factura cuando se ejecutan las funciones con tiempo de espera de 5min (default) hasta 10 min.

- Plan de Azure App Service: 
Evitar los períodos de tiempo de espera al tener la función en ejecución continuamente en una máquina virtual definida.


## _Ejecutar Azure Functions_

### Desencadenadores - TRIGGERS
Las funciones se basan en eventos, lo que significa que se ejecutan en respuesta a un evento. El tipo de evento que inicia la función se denomina desencadenador o TRIGGER.

Azure admite TRIGGERS para los servicios:
- Blob Storage> Inicia una función cuando se detecta un blob nuevo o actualizado.
- Azure Cosmos DB	> Inicia una función cuando se detectan inserciones y actualizaciones.
- Event Grid > Iniciar una función cuando se recibe un evento de Event Grid.
- HTTP	> Inicia una función con una solicitud HTTP.
- Eventos de Microsoft Graph	> Inicia una función como respuesta a un webhook entrante desde Microsoft Graph. Cada instancia de este desencadenador puede reaccionar a un tipo de recurso de Microsoft Graph.
- Queue Storage	> Inicia una función cuando se recibe un nuevo elemento en una cola. El mensaje de la cola se proporciona a modo de entrada para la función.
- Service Bus	> Inicia una función en respuesta a los mensajes de una cola de Service Bus.
- Temporizador o TIMER	> Inicia una función según una programación.

### Enlaces - BINDINGS
Son una manera de conectar servicios. A traves de los enlaces no es necesario escribir codigo para conectarse con un datasource u otras fuentes de datos o servicios. Cada enlace puede tener un enlace de entrada donde lee datos y uno de salida donde escribe datos. El TRIGGER es un ejemplo de BINDING pero con la capacidad adicional de iniciar la ejecucion.

```
We will need to supply the key when we send the HTTP request. 
You can send it as a query string parameter named code, or as an HTTP header 
(preferred) named x-functions-key.

default KEY:
E/Hu0RLfDEaEat6/xQLvFYUafQW8x8UyOcr8iAFXhafoVEuG68ba6A==

Function URL:
https://escalator-functions-devniel93-1.azurewebsites.net/api/HttpTrigger1?code=E/Hu0RLfDEaEat6/xQLvFYUafQW8x8UyOcr8iAFXhafoVEuG68ba6A==

Test+Run
curl --header "Content-Type: application/json" --header "x-functions-key: <your-function-key>" --request POST --data "{\"name\": \"Azure Function\"}" https://<your-url-here>/api/DriveGearTemperatureService

curl --header "Content-Type: application/json" --header "x-functions-key: E/Hu0RLfDEaEat6/xQLvFYUafQW8x8UyOcr8iAFXhafoVEuG68ba6A==" --request POST --data "{\"name\": \"Azure Function\"}" https://escalator-functions-devniel93-1.azurewebsites.net/api/HttpTrigger1?code=E/Hu0RLfDEaEat6/xQLvFYUafQW8x8UyOcr8iAFXhafoVEuG68ba6A==/api/DriveGearTemperatureService
```