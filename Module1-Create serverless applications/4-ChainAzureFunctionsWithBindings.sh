Encadenamiento de Azure Functions mediante Bindings de entrada y salida

Qué es un enlace o BINDING?
En Azure Functions, los enlaces permiten conectarse de manera declarativa a 
datos desde el código. Puede tener varios enlaces que proporcionan acceso a 
diferentes elementos de datos.

Tipos de enlaces
- Enlace de entrada: es una conexión a un origen de datos. La función puede 
leer datos de estas entradas.
- Enlace de salida: es una conexión a un destino de datos. La función puede 
escribir datos en estos destinos.

También hay desencadenadores que un tipo especial de enlaces de entrada que 
hacen que una función se ejecute.

Propiedades de los enlaces
- Name: define el parámetro de función a través del que se accede a los datos. 
Por ejemplo, en un enlace de entrada de cola, este es el nombre del parámetro 
de función que recibe el contenido del mensaje de cola.
- Type: identifica el tipo de enlace, es decir, el tipo de datos o servicio 
con el que se quiere interactuar.
- Direction: identifica la dirección en la que fluyen los datos, es decir, 
si es un enlace de entrada o salida.
- Connection: proporciona el nombre de una clave de configuración de 
aplicación que contiene la cadena de conexión

Lectura de datos con enlaces de entrada
Para conectarse a un origen de datos, se configura un enlace de entrada. 

Tipos de enlace de entrada
- Blob Storage: los enlaces de almacenamiento de blobs permiten leer un blob.
- Azure Cosmos DB: usa la API de SQL para recuperar uno o varios documentos de 
Azure Cosmos DB y los pasa al parámetro de entrada de la función. Se puede 
determinar el identificador de documento o los parámetros de consulta según 
el desencadenador que invoca la función.
- Mobile Apps: el enlace de entrada de Mobile Apps carga un registro desde 
un punto de conexión de tabla móvil y lo pasa a la función.
- Almacenamiento de tablas: puede leer los datos y trabajar con Azure Table 
Storage.

¿Qué es una expresión de enlace o BINDING EXPRESSION?
Es texto especializado en function.json, parámetros de función o código que 
se evalúa cuando se invoca la función para producir un valor.

Tipos de expresiones de enlace
- Configuración de la aplicación
- Nombre de archivo de desencadenador
- Metadatos de desencadenador
- Cargas JSON
- GUID nuevos
- Fecha y hora actual

La mayoría de las expresiones se identifican encerrándolas entre llaves. 
Sin embargo, las expresiones de enlace de configuración de aplicaciones se 
encapsulan en signos de porcentaje en lugar de entre llaves. Por ejemplo, 
si la ruta de acceso del enlace de salida de blob es 
%Environment%/newblob.txt y el valor de configuración de aplicación 
Environment es Development, se creará un blob en el contenedor Development.

httptrigger1 function
https://binding-types-devniel93.azurewebsites.net/api/HttpTrigger1?code=arJLInE70ET/C5EaUr8cgBycI8wjISI4pND9HOUkN7l9azm9j0a9Ww==

find-bookmar function
https://binding-types-devniel93.azurewebsites.net/api/find-bookmark?code=neYBPtoVQszxOfgPJzrtKIhyMmyT7NmyLj1oEc0Ouw7aNJmTHmAe6g==

index.js before:
module.exports = function (context, req) {
    context.log('JS HTTP Trigger function processed a request');
    if(req.query.name || (req.body && req.body.name)) {
        context.res = {
            body: "Hello " + req.query.name
        }
    }
    else{ 
        context.res = {
            status: 400,
            body: "Please pass a name"
        }
    }    
	context.done();
 };
 
 
index.js after:
module.exports = function (context, req) {
   var bookmark = context.bindings.bookmark
   if(bookmark){
       context.res = {
       body: { "url": bookmark.url },
       headers: {
       'Content-Type': 'application/json'
           }
       };
   }
   else {
    context.res = {
       status: 404,
       body : "No bookmarks found",
       headers: {
       'Content-Type': 'application/json'
       }
    };
   }
   context.done();
};
 
test function url: 
https://binding-types-devniel93.azurewebsites.net/api/find-bookmark?code=neYBPtoVQszxOfgPJzrtKIhyMmyT7NmyLj1oEc0Ouw7aNJmTHmAe6g==&name=dev&id=docs

function add-bookmark
https://binding-types-devniel93.azurewebsites.net/api/add-bookmark?code=yk3SyRBXRaNl/0MOTi4Pcuo1PRJzMpSfOf0l95qkNWyjSRBLKvUDOQ==

index.js:
module.exports = function (context, req) {
    var bookmark = context.bindings.bookmark
    if(bookmark){
            context.res = {
            status: 422,
            body : "Bookmark already exists.",
            headers: {
            'Content-Type': 'application/json'
            }
        };
    }
    else {        
        // Create a JSON string of our bookmark.
        var bookmarkString = JSON.stringify({ 
            id: req.body.id,
            url: req.body.url
        });
        // Write this bookmark to our database.
        context.bindings.newbookmark = bookmarkString;
        // Push this bookmark onto our queue for further processing.
        context.bindings.newmessage = bookmarkString;
        // Tell the user all is well.
        context.res = {
            status: 200,
            body : "bookmark added!",
            headers: {
            'Content-Type': 'application/json'
            }
        };
    }
    context.done();
};
