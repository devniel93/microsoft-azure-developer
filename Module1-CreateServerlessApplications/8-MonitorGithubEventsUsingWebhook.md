# Supervision de eventos de Github mediante un webhook con Azure Functions

## _¿Qué es un webhook?_
Son devoluciones de llamada HTTP definidas por el usuario. Se desencadenan por algún evento, como la inserción de código en un repositorio o la actualización de una página wiki. Cuando se produce el evento, en el sitio de origen se realiza una solicitud HTTP a la dirección URL configurada para el webhook. 
Con Azure Functions, se puede definir la lógica en una función que se puede ejecutar cuando se recibe un mensaje de webhook.

Un uso habitual de webhooks en un entorno de DevOps consiste en notificar a una función de Azure que ha cambiado la configuración o el código de una  aplicación en GitHub. Se puede utilizar el webhook con una función para realizar una tarea como la implementación de la versión actualizada de la aplicación.

### Creación de una función de Azure desencadenada por un webhook

1. Crear un Function App 

2. Agregar nueva funcion tipo HTTP Trigger

3. Configuracion de webhook para un repo GitHub
Crear un repo en github 
Agregar un page al wiki del repo
En configuracion del repo, agregar un webhook apuntando a la URL de la 
funcion. 
En contenttype seleccionar Json y en eventos seleccionar Wiki

4. Prueba de webhook
Editar el page creado en la wiki
Ver los Recent Deliveries en la opcion Webhook del repo.

### Desencadenamiento de una función de Azure Fuctions con un evento de GitHub
1. Editar en index.js de la funcion HttpTrigger
```
if (req.body.pages[0].title){
    context.res = {
        body: "Page is " + req.body.pages[0].title + ", Action is " + req.body.pages[0].action + ", Event Type is " + req.headers['x-github-event']
    };
}
else {
    context.res = {
        status: 400,
        body: ("Invalid payload for Wiki event")
    }
}
```
2. En GitHub, reenviar el ultimo envio reciente y comprobar la nueva respuesta


### Protección de las cargas de webhook con un secreto
1. Copiar la clave desde la opcion Function Keys
bRnN567jh1KwHZupXj8iFnNXOJNj2v5Igtbvlh1VDji6B3zf9gYPpw==

2. En el index.js de la funcion HttpTrigger editar
```
const Crypto = require('crypto');

module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const hmac = Crypto.createHmac("sha1", "bRnN567jh1KwHZupXj8iFnNXOJNj2v5Igtbvlh1VDji6B3zf9gYPpw==");
    const signature = hmac.update(JSON.stringify(req.body)).digest('hex');
    const shaSignature =  `sha1=${signature}`;
    const gitHubSignature = req.headers['x-hub-signature'];

    if (!shaSignature.localeCompare(gitHubSignature)) {
        if (req.body.pages[0].title) {
            context.res = {
                body: "Page is " + req.body.pages[0].title + ", Action is " + req.body.pages[0].action + ", Event Type is " + req.headers['x-github-event']
            };
        }
        else {
            context.res = {
                status: 400,
                body: ("Invalid payload for Wiki event")
            }
        }
    }
    else {
        context.res = {
            status: 401,
            body: "Signatures don't match"
        };
    }
};
```
3. En GitHub editar el secret del webhook con la clave

4. Probar un reenvio para comprobar que esta funcionando el match del signature