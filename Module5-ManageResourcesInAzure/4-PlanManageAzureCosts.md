# Planeación y administración de los costos de Azure

## _¿Qué es la calculadora de TCO?_
Ayuda a calcular los costos que se ahorra al hacer funcionar la solución en Azure con el tiempo, en lugar de hacerlo en el centro de datos local. El término costo total de propiedad se usa normalmente en finanzas. 

### Cómo funciona la calculadora de TCO?
El trabajo con la calculadora de TCO involucra tres pasos:
- Definir las cargas de trabajo: Escribir las especificaciones de la infraestructura local en funcion de:
    - Servidores: incluye los sistemas operativos, los métodos de virtualización, los núcleos de CPU y la memoria (RAM).
    - Base de datos: incluye los tipos de base de datos, el hardware de servidores y el servicio de Azure que quiere usar
    - Storage: incluye el tipo y la capacidad de almacenamiento, incluida toda copia de seguridad o almacenamiento de archivo
    - Redes: incluye la cantidad de ancho de banda de red que se usa actualmente en el entorno local.

- Ajustar los supuestos: Se puede reutilizar lcencias en Azure si es que estan inscritas para _Software Assurance_. Tambien se puede ahorrar evaluando si es necesario replicar a nivel de regiones. Las proyeciones por costos operativos estan certificados por Nucleus Researc y comprenden:
    - Precio de electricidad por kilovatios/hora (KWh).
    - Tarifa por hora para la administración de TI.
    - Costo de mantenimiento de la red como un porcentaje de los costos de software y hardware de red.

- Consulte el informe: Se puede escoger un período de tiempo entre uno y cinco años. La calculadora de TCO genera un informe que se basa en la información especificada. Se puede ver una comparación en paralelo del desglose de costos de funcionamiento de esas cargas de trabajo locales frente a su funcionamiento en Azure.

## _¿Qué tipos de suscripciones de Azure puedo usar?_

- Evaluación gratuita:
Una suscripción de evaluación gratuita proporciona 12 meses de servicios gratuitos populares, un crédito para explorar cualquier servicio de Azure durante 30 días y más de 25 servicios que siempre son gratis. Los servicios de Azure se deshabilitan cuando la evaluación termina o cuando el crédito expira para los productos de pago, a menos que actualice a una suscripción de pago.

- Pago por uso:
Una suscripción de pago por uso le permite pagar por lo que usa al conectar una tarjeta de crédito o débito a su cuenta. Las organizaciones pueden solicitar descuentos por volumen y facturación de pago por adelantado.

- Ofertas para miembros:
La pertenencia existente a determinados productos y servicios de Microsoft puede proporcionarle créditos para su cuenta de Azure y tarifas reducidas en los servicios de Azure. Por ejemplo, las ofertas para miembros están disponibles para los suscriptores de Visual Studio, los miembros de Microsoft Partner Network, los miembros de Microsoft for Startups y los miembros de Microsoft Imagine.

## _¿Cómo compro servicios de Azure?_
- A través de un Contrato Enterprise
- Directamente desde la web
- A través de un Proveedor de soluciones en la nube

## _¿Qué factores afectan al costo?_
- Tipo de recurso
- Medidores de uso: Los siguientes tipos de medidores son pertinentes para el seguimiento de su uso:
    - Tiempo total de CPU.
    - Tiempo empleado en una dirección IP pública.
    - Tráfico de red entrante (entrada) y saliente (salida) de la máquina virtual.
    - Tamaño del disco y cantidad de operaciones de lectura y escritura del disco.

- Uso de recursos
- Tipos de suscripción de Azure
- Location o ubicacion
- Zonas para la facturación del tráfico de red:  el precio de la transferencia de datos se basa en las zonas. Una zona es una agrupación geográfica de regiones de Azure para fines de facturación. 