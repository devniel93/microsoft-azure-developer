# Ejecucion de un Azure Function con Triggers o desencadenadores
La diferencia entre un TRIGGER y un BINDING en un Function, es que el function puede tener solo un TRIGGER de cualquier tipo (http, temporizador, blob, cosmosdb, cola) mientras que una funcion puede tener varios BINDINGS.

## _TIMER TRIGGER - Temporizador_
Es un desencadenador que ejecuta una función en un intervalo uniforme. Debe proporcionar dos fragmentos de información:
- Un Nombre de parámetro de marca de tiempo, que es simplemente un identificador.
- Una Programación, que es una expresión `CRON`.

## _HTTP TRIGGER_
Es un desencadenador que ejecuta una función cuando recibe una solicitud HTTP. Proporcionan acceso autorizado mediante el suministro de claves. Restringen qué verbos HTTP se admiten. Reciben datos a través de parámetros de cadena de consulta o del request body. Admiten plantillas de ruta de dirección URL para modificar la dirección URL.

Cuando se crea un HTTP TRIGGER, selecciona un lenguaje de programación, proporciona un nombre y selecciona un nivel de autorización.

### ¿Qué es un nivel de autorización de desencadenador de HTTP?
Es una marca que indica si una solicitud HTTP entrante necesita una clave de API por motivos de autenticación. 
Hay 3 niveles:
- Function: Requieren clave para acceder a la funcion.
- Anonymous: No requiere clave.
- Admin: Requieren clave para acceder a la funcion.

Existen 2 tipos de claves: Host y Function y se refiere a su ambito o alcance. 
- Host permite acceder a las APIS a nivel de Function Apps 
- Function a nivel de su propia funcion. 

https://time-trigger-devniel93.azurewebsites.net/api/HttpTrigger1

---

## _¿Qué es Azure Storage?_
Es una solución de almacenamiento que admite todos los tipos de datos, lo que incluye blobs, colas y NoSQL. De alta disponibilidad, Seguro, Escalable, Administrado.
Es una solución de almacenamiento de objetos que se ha diseñado para almacenar grandes cantidades de datos no estructurados.
- Almacenar archivos
- Servir archivos
- Realizar streaming de audio y vídeo
- Registrar datos

Hay 3 tipos de Blobs:
- Blocks: De uso frecuente para guardar datos binarios y texto de forma eficaz.
- Append: Es igual que los Blocks pero estan mas disenados para anexar operaciones como la creacion de un archivo log que se esta actualizando constantemente.
- Pages: Compuesto de paginas y disenado para operaciones aleatorias y frecuentes de escritura y lectura.

## _BLOB TRIGGER_
Es un desencadenador que ejecuta una función cuando un archivo se carga o se actualiza en Azure Blob Storage. 