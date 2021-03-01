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

--- 

## _Comprender los costos estimados antes de implementar_
Al planear su solución en Azure, tenga en cuenta detenidamente los productos, servicios y recursos que necesita. Calcule los costos previstos mediante la Calculadora de precios y la calculadora de costo total de propiedad (TCO). Agregue solo los productos, servicios y recursos que necesita para la solución.

## _Usar Azure Advisor para supervisar la utilización_
Identifica los recursos no utilizados o infrautilizados, y recomienda recursos no utilizados que se pueden quitar. Esta información le ayudará a configurar los recursos para que coincidan con la carga de trabajo real.

## _Usar límites de gasto para restringir los gastos_
Se puede usar los límites de gasto para evitar la saturación accidental. Si se tiene una suscripción basada en crédito y alcanza el límite de gasto configurado, Azure suspende su suscripción hasta que comience un nuevo período de facturación. Un concepto relacionado es el de cuotas o límites en el número de recursos similares que se pueden aprovisionar dentro de la suscripción. 

## _Usar Reservas de Azure para pagar por adelantado_
Reservas de Azure ofrecen precios con descuento en determinados servicios de Azure. Reservas de Azure puede ahorrar hasta un 72 % en comparación con los precios de pago por uso. 

## _Elegir regiones y ubicaciones de bajo costo_
Si es posible, debe usar en aquellas ubicaciones y regiones donde el costo es menor.

## _Investigación de las ofertas de ahorro de costos disponibles_
Mantenerse al día de las últimas ofertas de clientes y suscripciones de Azure.

## _Usar Azure Cost Management + Billing para controlar gastos_
Es un servicio gratuito que le ayuda a comprender su factura de Azure, administrar su cuenta y sus suscripciones, supervisar y controlar los gastos de Azure, y optimizar el uso de recursos.

## _Aplicar etiquetas para identificar a los propietarios de costos_
Las etiquetas ayudan a administrar los costos asociados a los distintos grupos de productos y recursos de Azure. Puede aplicar etiquetas a grupos de recursos de Azure para organizar los datos de facturación.

## _Cambiar el tamaño de las máquinas virtuales infrautilizadas_
Una recomendación común que encontrará de Azure Cost Management + Billing y Azure Advisor es cambiar el tamaño o apagar las VM que están infrautilizadas o inactivas.

## _Desasignar máquinas virtuales durante las horas de inactividad_
Desasignar una máquina virtual significa que ya no se ejecuta la máquina virtual, sino que se conservan los discos duros y los datos asociados en Azure. Si tiene cargas de trabajo de VM que solo se usan durante determinados períodos, pero las ejecuta cada hora de cada día, está malgastando dinero.

## _Eliminar recursos no utilizados_
No es poco frecuente encontrar sistemas de prueba de concepto, o que no son de producción, que después de completar un proyecto ya no son necesarios.

## _Migración de servicios IaaS a PaaS_
Una manera de reducir costos es trasladar gradualmente las cargas de trabajo de IaaS para ejecutarlas en servicios de plataforma como servicio (PaaS). No solo la ejecución de servicios de PaaS como Azure SQL Database suele ser menos costosa, pero dado que se administran automáticamente, no es necesario preocuparse por las actualizaciones de software, las revisiones de seguridad ni optimizar el almacenamiento físico para operaciones de lectura y escritura.

## _Elección de sistemas operativos rentables_
Azure ofrecen una opción de ejecución en Windows o Linux.

## _Uso de la Ventaja híbrida de Azure para reasignar licencias de software en Azure_
Si ha adquirido licencias para Windows Server o SQL Server, y las licencias están cubiertas por Software Assurance, es posible que pueda reasignar esas licencias a VM de Azure.