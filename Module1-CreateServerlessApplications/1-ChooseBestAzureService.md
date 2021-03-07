# Azure workflows:

## TECNOLOGIAS ORIENTADAS AL DISENO:
- Logic Apps  
- Microsoft Power Automate

## TECNOLOGIAS ORIENTADAS AL CODIGO:
- WebJobs
- Azure Functions

Pueden aceptar ENTRADAS. Una entrada es un fragmento de datos o un archivo que se suministra al flujo de trabajo.
Pueden ejecutar ACCIONES. Una acción es una operación sencilla que el flujo de trabajo ejecuta y, a menudo, podría modificar datos o hacer que se realice otra acción.
Pueden incluir CONDICIONES. Una condición es una prueba que suele realizarse en una entrada y que podría decidir qué acción se ejecuta a continuación.
Pueden producir SALIDAS. Una salida es un fragmento de datos o un archivo creado por el flujo de trabajo.


## Logic Apps 
Servicio de Azure que sirve para automatizar, organizar e integrar los distintos componentes de una aplicación distribuida. Mediante el enfoque orientado al diseño, se puede dibujar flujos de trabajo complejos que sirvan como modelo para procesos empresariales complejos.

## Microsoft Power Automate 
Servicio que se puede usar para crear flujos de trabajo incluso si no se tiene experiencia profesional de TI o desarrollo. Puede crear flujos de trabajo que integren y organicen muchos componentes.

Tiene cuatro tipos de flujo:
- Automatizado: flujo que se inicia a través de un desencadenador de algún evento, como la llegada de un nuevo tweet o la carga de un nuevo archivo.
- Botón: use un flujo de botón para ejecutar una tarea repetitiva con un solo clic desde el dispositivo móvil.
- Programado: flujo que se ejecuta de forma periódica, por ejemplo, una vez por semana, en una fecha concreta o después de 10 horas.
- Proceso de negocio: flujo que modela un proceso de negocio, como la ordenación de las existencias o la gestión de quejas

## COMPARACION TECNOLOGIAS ORIENTADAS AL DISENO:

### Microsoft Power Automate	
- Usuarios previstos: Trabajadores de oficina y analistas de negocios	
- Escenarios previstos: Creación de flujos de trabajo de autoservicio	
- Herramientas de diseño:	Solo GUI. Explorador y aplicación móvil	
- Administración del ciclo de vida de las aplicaciones: Power Automate incluye entornos de producción y pruebas

### Logic Apps
- Usuarios previstos: Desarrolladores y profesionales de TI
- Escenarios previstos: Proyectos de integración avanzados
- Herramientas de diseño: Explorador y diseñador de Visual Studio. Es posible editar el código
- Administración del ciclo de vida de las aplicaciones: El código fuente de Logic Apps se puede incluir en Azure DevOps y sistemas de administración de código fuente

--- 

## Azure App Service 
Servicio de hospedaje basado en la nube para aplicaciones web, back-end para dispositivos móviles y API RESTful. A menudo necesitan realizar algún tipo de tarea en segundo plano.

## WebJobs 
Es una parte de Azure App Service que se puede usar para ejecutar un programa o un script de manera automática. Y tiene 2 tipos:
- Continuo: Estos trabajos web se ejecutan en un bucle continuo. Por ejemplo, podría usar un trabajo web continuo para buscar en una carpeta compartida una nueva foto.
- Desencadenado: Estos trabajos web se ejecutan cuando se inician manualmente o según una programación.

## Azure Functions 
Es una manera sencilla de ejecutar pequeños fragmentos de código en la nube sin tener que preocuparse por la infraestructura necesaria para hospedar ese código. Además, con la opción de plan de consumo, solo paga por el tiempo durante el que se ejecuta el código. Azure escala automáticamente la función en respuesta a la demanda de los usuarios.

Para crear una función de Azure Functions, se puede elegir entre diversas plantillas:
- HTTPTrigger: plantilla cuando quiera que el código se ejecute en respuesta a una solicitud enviada a través del protocolo HTTP.
- TimerTrigger: plantilla cuando quiera que el código se ejecute según una programación.
- BlobTrigger: plantilla cuando quiera que el código se ejecute en el momento en que se agregue un nuevo blob a una cuenta de Azure Storage.
- CosmosDBTrigger: plantilla cuando quiera que el código se ejecute en respuesta a documentos nuevos o actualizados en una base datos de NoSQL.

## COMPARACION TECNOLOGIAS ORIENTADAS AL CODIGO:
---------------------------------------------

### Azure WebJobs
Lenguajes admitidos	C# (si usa el SDK de WebJobs)	
Escalado automático	No	
Desarrollo y pruebas en un explorador	No	
Precios de pago por uso	No	
Integración con Logic Apps	No	
Administradores de paquetes	NuGet (si usa el SDK de WebJobs)	
Puede formar parte de una aplicación de App Service	Sí	No
Proporciona un control detallado de JobHost	Sí	

### Azure Functions
Lenguajes admitidos C#, Java, JavaScript, PowerShell, etc.
Escalado automático	Sí
Desarrollo y pruebas en un explorador	Sí
Precios de pago por uso	Sí
Integración con Logic Apps	Sí
Administradores de paquetes	NuGet y NPM
Puede formar parte de una aplicación de App Service	No
Proporciona un control detallado de JobHost	No