###Exponer varias Function App como una API mediante Azure API Management

Arquitectura Servless y microservicios
- Los microservicios se han convertido en un enfoque popular para la 
arquitectura de aplicaciones distribuidas
- Cuando se crea una aplicación como una colección de microservicios, crea 
muchos servicios pequeños diferentes. Cada servicio tiene un dominio de 
responsabilidad definido, y se desarrolla, implementa y escala de forma 
independiente. 
- Facilita la entrega continua porque, cuando implementa un microservicio, 
cambia solo una pequeña parte de toda la aplicación
- Otra tendencia complementaria en el desarrollo de software distribuido es 
la arquitectura Serverless. Los desarrolladores no tienen que preocuparse por 
el hardware de soporte, los sistemas operativos, el software subyacente y 
otras infraestructuras. Su código se ejecuta en recursos informáticos sin 
estado que se desencadenan mediante solicitudes
 
Azure API Management
- Permite construir una API a partir de un conjunto de microservicios dispares.
- Es un servicio en la nube totalmente administrado que puede usar para 
publicar, proteger, transformar, mantener y supervisar API
- API Management controla todas las tareas involucradas en la mediación de 
llamadas API, lo que incluye la autenticación y autorización de solicitudes, 
el límite de velocidad y el cumplimiento de cuotas, la transformación de 
solicitudes y respuestas, el registro y el seguimiento y la administración de 
versiones API

#########
Creaion de una nueva API en API Management a partir de un Function App

1. Clonar proyecto de funciones de ejemplo 
git clone https://github.com/MicrosoftDocs/mslearn-apim-and-functions.git ~/OnlineStoreFuncs

2. Ejecutar para configurar recursos en Azure
Se creara 2 Function App cada uno con una funcion OrdersDetails y 
ProductDetails

cd ~/OnlineStoreFuncs
bash setup.sh

4. Testear la funcion ProductFunction en AzurePortal 

Example url:
https://productfunctiondc3bf0c828.azurewebsites.net/api/ProductDetails?code=nyk4EP9xEDgeW1yXILCQ58LcSk1ysalXz5eBStGfBOCZDxsEthvquw==&id=2

Notese que el dominio de la funcion es azurewebsites.net

5. Exponer Function App en el Azure APIM

Seleccionar el recurso ProductFunction
Ir a API Management y crear nuevo 
Vincular API e importa Azure Function > ProductDetails
Cambiar el sufijo de la direcion URL de API > products

6. Testar el API desde el Portal Azure

Notese que el dominio de la URL cambio por el de APIM
https://myapim-devniel93.azure-api.net/products/ProductDetails...









