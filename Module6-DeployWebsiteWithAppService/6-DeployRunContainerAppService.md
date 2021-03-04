# Implementación y ejecución de una aplicación web en contenedores con Azure App Service
Crear una imagen de Docker y guardarla en un repositorio en Azure Container Registry. Utilizar Azure App Service para implementar una aplicación web basada en la imagen de Docker. Configurar la implementación continua de la aplicación web con un webhook que supervisa la imagen de Docker en busca de cambios.

## _¿Qué es Container Registry?_
Es un servicio de Azure para crear propios registros de Docker privados. Al igual que Docker Hub, Container Registry está organizado en torno a repositorios que contienen una o más imágenes. También le permite automatizar tareas como la reimplementación de una aplicación cuando se vuelve a crear una imagen. 

### Ventajas de Azure Container Registro frente a Docker Hub:
- Tiene mucho más control sobre quién puede ver y usar las imágenes.
- Puede firmar las imágenes para aumentar la confianza y reducir las posibilidades de que una imagen se dañe o se infecte de manera accidental (o intencionadamente).
- Todas las imágenes almacenadas en el registro de contenedor están cifradas en reposo.
- El registro se puede replicar para almacenar imágenes cerca de donde es probable que se implementen.
- Container Registry es altamente escalable, y proporciona un mejor rendimiento para los comandos docker pulls que pueden abarcar muchos nodos simultáneamente. 

### Uso de Container Registry
Para crear un registro por Azure CLI 
```
az acr create --name myregistry --resource-group mygroup --sku standard --admin-enabled true
```

Para compilar una imagen 
```
az acr build --file Dockerfile --registry myregistry --image myimage .
```

### Creacion de un registro por Azure Portal
1. En Azure Portal > Crear un recurso > Contenedores > Container Registry
2. Ingresar nombre de registro, suscripcion, RG, ubicacion, SKU
3. Crear
4. Descargar codigo fuente de aplicacion web de ejemplo.
```
git clone https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git
```
5. Compilar la imagen y almacenar en el Azure Container Registry 
```
cd mslearn-deploy-run-container-app-service/node
az acr build --registry <container_registry_name> --image webimage .
```
6. En Azure Portal > Container Registry > Servicios > Repositorios para ver el registro con la imagen 

---

## _Implementación de una aplicación web con una imagen desde un repositorio de Azure Container Registry_
Se puede implementar una aplicación web en Azure App Service directamente desde Azure Container Registry. Al crear una aplicación web a partir de una imagen de Docker, se configuran las siguientes propiedades:

- El registro que contiene la imagen que puede ser Docker Hub, Azure Container Registry o algún otro registro privado.
- La imagen. Este elemento es el nombre del repositorio.
- La etiqueta. Este elemento indica qué versión de la imagen se va a usar desde el repositorio. Por convención, a la versión más reciente se le asigna la etiqueta `latest` cuando se compila.
- Archivo de inicio. Este elemento es el nombre de un archivo ejecutable o un comando que se debe ejecutar cuando se carga la imagen. Es equivalente al comando que puede proporcionar a Docker cuando ejecuta una imagen desde la línea de comandos con `docker run` 

### Creación e implementación de una aplicación web desde una imagen de Docker
1. Habilitar el acceso de Docker a ACR
En Azure Portal > Informacion General del ACR creado > Configuracion > Claves de Aceso > Habilitar la opcion Usuario Administrador.
2. Crear la aplicacion web
En Azure Portal > Crear recurso > Web > Aplicacion web 
Ingresar suscripcion, RG, nombre, publicar como Contenedor de Docker, SO Linux y plan de App Service predeterminado.
En la seccion de Docker > opciones contenedor unico, origen de la imagen Azure Container Registry, seleccionar el registro, imagen, etiqueta `latest`, comando de incio dejar en blanco.
Revisar y crear > Crear
3. Probar la aplicacion web
En Azure Portal > Aplicacion Web > Informacion General > Examinar y ver el sitio en el explorador.

## _Actualización de la imagen y reimplementación automática de la aplicación web_
La implementación continua es una característica que permite implementar la versión más reciente del software rápidamente, pero con el mínimo de esfuerzo.

### ¿Qué es un webhook?
Es un servicio ofrecido por Azure Container Registry. Los servicios y aplicaciones pueden suscribirse al webhook para recibir notificaciones sobre actualizaciones de imágenes en el registro. Cuando la imagen se actualiza y App Service recibe una notificación, la aplicación reinicia automáticamente el sitio y extrae la última versión de la imagen.

### ¿Qué es la característica _tareas_ de Container Registry?
Se usa para recompilar la imagen siempre que su código fuente cambia automáticamente. Puede configurar una tarea de Container Registry para supervisar el repositorio de GitHub que contiene el código y desencadenar una compilación cada vez que cambie. 

### Habilitación de la integración continua desde App Service
La página Configuración del contenedor de un recurso de App Service en Azure Portal automatiza la configuración de la integración continua. Si activa Implementación continua, App Service configura un webhook en el registro de contenedor para notificar a un punto de conexión de App Service. 

## _Ampliación de la integración continua al control de código fuente mediante una tarea de Container Registry_
El siguiente comando muestra cómo crear una tarea llamada buildwebapp, el cual supervisa el repo Github para la web app. Cada vez que hay un cambio, la tare compila la imagen de Docker y la almacena en ACR.
```
az acr task create \
--registry <container_registry_name> \
--name buildwebapp --image webimage \
--context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git \
--branch master \
--file Dockerfile \
--git-access-token <access_token>
```

---

## _Configuración de la implementación continua y creación de un webhook
1. En Azure Portal > Web App > Configuracion del contenedor
2. Activar Implementacion continua > Guardar. En esta configuración se configura un webhook que Container Registry puede usar para alertar a la aplicación web de que la imagen de Docker ha cambiado.
3. Actualización de la aplicación web y prueba del webhook
Editar el archivo `index.js`
```
cd ~/mslearn-deploy-run-container-app-service/node/routes
code index.js

...
res.render('index', { title: 'Microsoft Learn' });
...
```
4. Recompilar la imagen e instalarla en ACR
```
cd ~/mslearn-deploy-run-container-app-service/node
az acr build --registry <container_registry_name> --image webimage .
```

5. Se puede comprobar el registro de webhook que acaba de activarse de la compilacion en la seccion de Webhooks del ACR en Azure Portal

6. Probar la aplicacion web