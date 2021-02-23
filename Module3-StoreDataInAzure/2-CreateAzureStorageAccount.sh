¿Qué es Azure Storage?
Azure seleccionó cuatro servicios de datos y los agrupó bajo el nombre 
Azure Storage: Azure Blobs, Azure Files, Azure Queues y Azure Tables. 

¿Qué es una cuenta de almacenamiento?
- Es un contenedor que agrupa un conjunto de servicios de almacenamiento de 
Azure. 
- Solo se pueden incluir servicios de datos de Azure Storage (Azure Blobs, 
Azure Files, Azure Queues y Azure Tables).
- La combinación de servicios de datos en una cuenta de almacenamiento 
permite administrarlos como grupo.
- La configuración que especifique al crear la cuenta o cualquier opción 
que cambie tras la creación, se aplica a todo el contenido de la cuenta.
- Al eliminar la cuenta de almacenamiento se eliminan todos los datos 
que contiene.
- Una cuenta de almacenamiento es un recurso de Azure y se incluye en 
un grupo de recursos. 
- Otros servicios de datos de Azure, como Azure SQL y Azure Cosmos DB, se 
administran como recursos de Azure independientes y no se pueden incluir 
en una cuenta de almacenamiento. 

Configuración de las cuentas de almacenamiento
Una cuenta de almacenamiento define una directiva que se aplica a todos 
los servicios de almacenamiento de esta:
- Suscripción: suscripción a la que se facturan los servicios de la cuenta.
- Location: centro de datos en el que se almacenan los servicios de la 
cuenta.
- Rendimiento: determina los servicios de datos que se pueden tener en la 
cuenta de almacenamiento y el tipo de discos físicos que se usan para 
almacenar los datos. Estándar: permite tener cualquier servicio de datos 
(blobs, archivos, colas, tablas) y usa unidades de disco 
magnéticas. Premium: incorpora servicios adicionales para almacenar datos.
- Replicación: determina la estrategia que se usa para realizar copias de 
los datos, con el fin de protegerlos contra errores de hardware o 
desastres naturales. 
- Nivel de acceso: controla la rapidez de acceso a los blobs en esta 
cuenta de almacenamiento. El nivel Frecuente es más rápido que el nivel 
Esporádico, pero el costo también es mayor. Esto se aplica solo a los 
blobs.
- Se requiere transferencia segura:  característica de seguridad que 
permite HTTPS o HTTP.
- Redes virtuales: característica de seguridad que permite recibir 
solicitudes de acceso de entrada solo desde las redes virtuales que 
especifique.

Diversidad de los datos
Las organizaciones suelen generan datos que difieren en el lugar de 
consumo, el grado de confidencialidad, el grupo que paga las facturas, 
etc. La diversidad en cualquiera de estos vectores puede derivar en la 
necesidad de distintas cuentas de almacenamiento. 

Susceptibilidad a los costos
Una cuenta de almacenamiento en sí no supone costos económicos; sin 
embargo, la configuración que se elija para la cuenta afecta al costo de 
los servicios de esta. El almacenamiento con redundancia geográfica 
cuesta más que el almacenamiento con redundancia local. El nivel de acceso 
frecuente y el rendimiento Premium aumentan el costo de los blobs.

Para reducir los costos, puede usar varias cuentas de almacenamiento. Por 
ejemplo, puede dividir los datos en dos categorías: críticos y no críticos.

