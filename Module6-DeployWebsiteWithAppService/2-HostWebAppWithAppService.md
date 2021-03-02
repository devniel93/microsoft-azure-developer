# Hospedaje de una aplicación web con Azure App Service
Hospedar la aplicación web con Azure App Service hace que la implementación y administración de una aplicación web resulten mucho más fáciles en comparación con la administración de un servidor físico. 

## _Qué es Azure App Service_
Es una plataforma de hospedaje de aplicaciones web totalmente administrada. Esta plataforma como servicio (PaaS) que ofrece Azure le permite centrarse en el diseño y la compilación de la aplicación, mientras que Azure se encarga de la infraestructura para ejecutar y escalar las aplicaciones.

### Ranuras de implementación
Se puede crear un espacio de implementación de pruebas donde puede insertar el código para probarlo en Azure, luego se puede intercambiar la ranura de implementación de ensayo con la ranura de producción.

### Compatibilidad con la integración e implementación continuas
Azure Portal proporciona integración e implementación continuas listas para usar con Azure DevOps, GitHub, Bitbucket, FTP o un repositorio de GIT local en el equipo de desarrollo. 

### Publicación de Visual Studio integrada y publicación FTP
Visual Studio permite publicar la aplicación web en Azure mediante la tecnología Web Deploy. App Service también admite la publicación basada en FTP para flujos de trabajo más tradicionales.

### Compatibilidad integrada con la escalabilidad automática (escalabilidad horizontal en función de la carga real)
En la aplicación web se integra la capacidad de escalar o reducir verticalmente, o bien escalar horizontalmente. En la aplicación web, se puede escalar o reducir verticalmente si se aumentan o disminuyen los recursos como el número de núcleos o la cantidad de memoria RAM disponible. Y en el escalado horizontal es la capacidad de aumentar el número de instancias de máquina que ejecutan la aplicación web. 

## _Planes de App Service_
Un plan de App Service es un conjunto de recursos de servidor virtual que ejecutan aplicaciones de App Service. El tamaño de un plan (que a veces se denomina SKU o plan de tarifa) determina las características de rendimiento de los servidores virtuales que ejecutan las aplicaciones asignadas al plan.

Un solo plan de App Service puede hospedar varias aplicaciones web de App Service. Son la unidad de facturación de App Service. 

--- 

## _Crear Nuevo Web App_
1. Para crear nuevo web app

En java:
```
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp

cd helloworld
mvn package
```

En Node.js:
```
cd ~
mkdir helloworld
cd helloworld
npm init -y
touch index.js
```

Editar el archivo `package.json`
```
{
  "name": "helloworld",
  ...
  "scripts": {
    "start": "node index.js"
  },
  ...
}
```

Editar `index.js`
```
const http = require('http');

const server = http.createServer(function(request, response) {
    response.writeHead(200, { "Content-Type": "text/html" });
    response.end("<html><body><h1>Hello World!</h1></body></html>");
});

const port = process.env.PORT || 1337;
server.listen(port);

console.log(`Server running at http://localhost:${port}`);
```

---

## _Implementación automatizada_
Azure admite la implementación automatizada o la integración continua desde varios orígenes:

- Azure DevOps: Puede insertar el código en Azure DevOps (anteriormente conocido como Visual Studio Team Services), compilar el código en la nube, ejecutar las pruebas, generar una versión a partir del código y, por último, insertar el código en una aplicación web de Azure.
- GitHub: Azure admite la implementación automatizada directamente desde GitHub. Cuando conecte el repositorio de GitHub con Azure para la implementación automatizada, cualquier cambio que inserte en la rama de producción en GitHub se implementará de forma automática.
- Bitbucket: con sus similitudes con GitHub, puede configurar una implementación automatizada con Bitbucket.
- OneDrive: almacenamiento basado en la nube de Microsoft. Debe tener una cuenta de Microsoft vinculada a una de OneDrive para implementar en Azure.
- Dropbox: Azure admite la implementación desde Dropbox, que es un conocido sistema de almacenamiento basado en la nube parecido a OneDrive.

## _Implementación manual_

- Git: App Service Web Apps incluyen una dirección URL de Git que se puede agregar como repositorio remoto. Al insertar en el repositorio remoto se implementará la aplicación.
- `az webapp up`: `webapp up` es una característica de cli que empaqueta la aplicación y la implementa. A diferencia de otros métodos de implementación, az webapp up puede crear una aplicación web de App Service de forma automática si todavía no ha creado una.
- Implementación de archivo ZIP: Usar `az webapp deployment source config-zip` para enviar un ZIP de los archivos de la aplicación a App Service.
- Implementación desde un archivo WAR: es un mecanismo de implementación de App Service diseñado para implementar aplicaciones web de Java mediante paquetes WAR. Se puede acceder a la implementación desde un archivo WAR mediante la API Kudu de HTTP.
- Visual Studio: incluye un asistente para la implementación de App Service que puede guiar a través del proceso de implementación.
- FTP/S: FTP o FTPS es una manera tradicional de insertar el código en muchos entornos de hospedaje, incluido App Service.

## _Configuración de las credenciales de implementación_

1. Crear las credenciales para la implementacion de App Service de Azure CLI
```
az webapp deployment user set --user-name devniel93 --password somefakeP@ssword2021
```

2. Implementar paquete de aplicacion desde un archivo WAR
```
cd ~/helloworld/target
curl -v -X POST -u devniel93:somefakeP@ssword2021 https://mywebappdevniel93.scm.azurewebsites.net/api/wardeploy --data-binary @helloworld.war
```