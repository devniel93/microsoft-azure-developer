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
