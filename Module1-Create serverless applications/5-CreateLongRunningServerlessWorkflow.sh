¿Qué es Durable Functions?
Permite implementar funciones complejas con estado en un entorno sin servidor.
Es una extensión de Azure Functions. Mientras que Azure Functions opera en un
entorno sin estado, Durable Functions puede conservar el estado entre las
llamadas de función.

- Permite escribir código controlado por eventos. Una función real puede 
esperar de manera asincrónica uno o varios eventos externos y, luego, 
realizar una serie de tareas en respuesta a estos eventos.

- Las funciones se pueden encadenar. Puede implementar patrones comunes 
como distribución ramificada de salida/entrada, que usa una función para
invocar a otras en paralelo y, luego, acumular los resultados.

- Puede organizar y coordinar funciones y especificar el orden en que se 
deben ejecutar las funciones.

- El estado se administra de manera automática. No es necesario que escriba 
su propio código para guardar información de estado para una función de larga 
duración.

Durable Functions permite definir flujos de trabajo con estado mediante una 
función de orquestación

- Puede definir flujos de trabajo en el código. No es necesario que escriba una 
descripción JSON ni usar una herramienta de diseño flujo de trabajo.

- Las funciones se pueden llamar de manera sincrónica y asincrónica.

- Azure controla el progreso de una función de manera automática cuando 
la función espera. Azure puede optar por deshidratar la función y guardar su 
estado mientras la función espera, para conservar así los recursos y disminuir 
los costos.

Tipos de función
- Cliente: son el punto de entrada para crear una instancia de una 
orquestación de Durable Functions. Se pueden ejecutar en respuesta a un 
evento de muchos orígenes, como una solicitud HTTP, un mensaje que se 
publica en una cola de mensajes, un evento que llega en una 
secuencia de eventos. 

- Orquestador: describen cómo se ejecutan las acciones y el orden en que se 
ejecutan. Puede escribir la lógica de orquestación en el código (C# o 
JavaScript).

- Actividad: son las unidades de trabajo básicas de una orquestación de 
función durable. Una función de actividad contiene el trabajo real realizado 
por las tareas que se están organizando.

Patrones de aplicación
- Encadenamiento de funciones: 
En este patrón, el flujo de trabajo ejecuta una secuencia de funciones en 
un orden especificado. La salida de una función se aplica a la entrada de 
la función siguiente en la secuencia. La salida de la función final se usa 
para generar un resultado.

- Distribución ramificada de salida/entrada: 
Ejecuta varias funciones en paralelo y luego espera a que se 
completen todas. Los resultados de las ejecuciones en paralelo se pueden 
agregar o usar para calcular un resultado final.

- API HTTP asincrónicas: 
Aborda el problema de coordinar el estado de las operaciones de larga 
ejecución con clientes externos. Una llamada HTTP puede desencadenar 
la acción de larga duración. Luego, puede redirigir el cliente a un punto 
de conexión de estado. El cliente puede saber cuándo finaliza la operación 
si sondea este punto de conexión.

- Supervisión: 
Implementa un proceso recurrente en un flujo de trabajo, posiblemente en 
busca de un cambio en el estado.

- Interacción humana: 
Combina procesos automatizados que también implican interacción humana, la 
cual se puede incorporar mediante el uso de tiempos de espera y lógica de 
compensación que se ejecuta si el humano no puede interactuar correctamente 
dentro de un tiempo de respuesta especificado. 

Comparación con Logic Apps
Tanto Durable Functions como Logic Apps son servicios de Azure que 
posibilitan las cargas de trabajo sin servidor. Azure Durable Functions está 
pensado como una opción de proceso sin servidor eficaz para ejecutar una 
lógica personalizada. Azure Logic Apps es más adecuado para integrar 
componentes y servicios de Azure.

Azure Durable Functions	
- Desarrollo:	Orientado al código (imperativo)	Orientado al diseño (declarativo)
- Conectividad:	Alrededor de una docena de tipos de enlaces integrados. Puede escribir código para enlaces personalizados.	Gran colección de conectores. Enterprise Integration Pack para B2B. También puede crear conectores personalizados.
- Acciones:	Cada actividad es una función de Azure. Puede escribir el código para las funciones de actividad.	Gran colección de acciones listas para usar. Puede integrar una lógica personalizada a través de conectores personalizados.
- Supervisión:	Azure Application Insights	Azure Portal, registros de Azure Monitor
- Administración:	API REST, Visual Studio	Azure Portal, API REST, PowerShell, Visual Studio
- Contexto de ejecución:	Se puede ejecutar localmente o en la nube	Solo se ejecuta en la nube

Azure Logic Apps
- Desarrollo:	Orientado al diseño (declarativo)
- Conectividad:	Gran colección de conectores. Enterprise Integration Pack para B2B. También puede crear conectores personalizados.
- Acciones:		Gran colección de acciones listas para usar. Puede integrar una lógica personalizada a través de conectores personalizados.
- Supervisión:	Azure Portal, registros de Azure Monitor
- Administración:	Azure Portal, API REST, PowerShell, Visual Studio
- Contexto de ejecución: Solo se ejecuta en la nube


Para cear un workflow usando Durable Functions
1. Crear un Function App 

2.En Dev Tools > App Service Editor
Open console 

3. Crear un archivo json
touch package.json
open package.json

in package.json edit:

{
  "name": "example",
  "version": "1.0.0"
}

4. Instalar Durable Functions
npm install durable-functions

5. Reiniciar Function App
restart the function app

6. Crear un Durable Function del template HTTP Starter

7. Editar index.js:

const df = require("durable-functions");
module.exports = async function (context, req) {
    const client = df.getClient(context);
    const instanceId = await client.startNew(req.params.functionName, undefined, req.body);

    context.log(`Started orchestration with ID = '${instanceId}'.`);

    return client.createCheckStatusResponse(context.bindingData.req, instanceId);
};

8. Crear Durable Function orchestrator 
9. Editar index.js

const df = require("durable-functions");
module.exports = df.orchestrator(function* (context) {
    const outputs = [];

    /*
    * We will call the approval activity with a reject and an approved to simulate both
    */

    outputs.push(yield context.df.callActivity("Approval", "Approved"));
    outputs.push(yield context.df.callActivity("Approval", "Rejected"));

    return outputs;
});

10. Crear Duracle Functions Activity 

11. Editar index.js

module.exports = async function (context) {
    return `Your project design proposal has been -  ${context.bindings.name}!`;
};

12. Comprobar el inicio del workflow de Durable Function

Obtener del HTTPStart Function URL to run the functions:
https://mydurablefunctionapp-devniel93.azurewebsites.net/api/orchestrators/{functionName}?code=Cd9xkCnxc6ZeVRpuVkKlW2w8/ILrjYCv/Q3qrPChj5ZNiYZzaGuqaw==

Replace {functionName} with the name of orchestrator function 
https://mydurablefunctionapp-devniel93.azurewebsites.net/api/orchestrators/OrchFunction?code=Cd9xkCnxc6ZeVRpuVkKlW2w8/ILrjYCv/Q3qrPChj5ZNiYZzaGuqaw==

In the response, run the url from the value statusQueryGetUri to view the output
https://mydurablefunctionapp-devniel93.azurewebsites.net/runtime/webhooks/durabletask/instances/462965eb6df94f72a091f54a0ab72eac?taskHub=DurableFunctionsHub&connection=Storage&code=HasvQP0U7nQWzbu8YfJTFxcLMXlBQJnqa2fddtf0ppOo/Yj5TB7aPA==

13. Crear un Activity Function llamado Escalation y editar su index.js

module.exports = async function (context) {
    return `ESCALATION : You have not approved the project design proposal - reassigning to your Manager!  ${context.bindings.name}!`;
};

14. Editar el Orchestrator Function para usar el Activity Function Escalation

module.exports = df.orchestrator(function* (context) {
    const outputs = [];
    const deadline = moment.utc(context.df.currentUtcDateTime).add(20, "s");
    const activityTask = context.df.waitForExternalEvent("Approval");
    const timeoutTask = context.df.createTimer(deadline.toDate());

    const winner = yield context.df.Task.any([activityTask, timeoutTask]);
    if (winner === activityTask) {
        outputs.push(yield context.df.callActivity("Approval", "Approved"));
    }
    else
    {
        outputs.push(yield context.df.callActivity("Escalation", "Head of department"));
    }

    if (!timeoutTask.isCompleted) {
        // All pending timers must be complete or canceled before the function exits.
        timeoutTask.cancel();
    }

    return outputs;
});

15. Restart el Function App

16. Probar el flujo del Durable Function llamando al HTTPStart Function
