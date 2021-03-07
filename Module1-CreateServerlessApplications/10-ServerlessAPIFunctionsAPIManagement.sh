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

########

Desafíos de la arquitectura de microservicios
- Las aplicaciones cliente están acopladas a los microservicios. Si desea 
cambiar la ubicación o la definición del microservicio, es posible que tenga 
que volver a configurar o actualizar la aplicación cliente.
- Cada microservicio se puede presentar en diferentes nombres de dominio o 
direcciones IP. Esta presentación puede dar una impresión de incoherencia a 
los usuarios y puede afectar negativamente a su marca.
- Puede ser difícil aplicar reglas y estándares de API coherentes en todos 
los microservicios. Por ejemplo, un equipo puede optar por responder con XML 
y otro puede preferir JSON
- Se depende de equipos individuales para implementar la seguridad en los 
microservicios correctamente. Es difícil imponer estos requisitos 
centralmente

Ventas de API Management
- Las aplicaciones del cliente están acopladas a la API que expresa la lógica 
empresarial, no a la implementación técnica subyacente con microservicios 
individuales. Puede cambiar la ubicación y la definición de los servicios sin 
tener que reconfigurar o actualizar necesariamente las aplicaciones cliente.
- API Management actúa como intermediario. Reenvía las solicitudes al 
microservicio correcto y devuelve las respuestas a los usuarios. Los usuarios 
nunca ven los diferentes URI donde se alojan los microservicios.
- Se puede usar directivas de API Management para aplicar reglas coherentes en 
todos los microservicios en el producto. Por ejemplo, se puede transformar 
todas las respuestas XML en JSON
- Las directivas también le permiten aplicar requisitos de seguridad coherentes.

##########

Agregar otro Function App a un API existente

1. Ir al recurso API Management en Azure Portal
2. Seleccionar API > Add API > Function App 
3. Importar Function App OrderFunction
4. Cambiar sufijo de direcion URL > orders
5. Crear API
6. Testear API en Azure Portal 
7. Se puede comprobar usando curl

Copiar el Gateway URL del recurso API Management y ejecutar
GATEWAY_URL=<paste the URL here>

Copiar la suscripcion/clave principal del APIM
SUB_KEY=<paste the key here>

Ejecutar curl
curl -X GET "$GATEWAY_URL/products/ProductDetails?id=2" -H "Ocp-Apim-Subscription-Key: $SUB_KEY"
curl -X GET "$GATEWAY_URL/orders/OrderDetails?name=Henri" -H "Ocp-Apim-Subscription-Key: $SUB_KEY"












