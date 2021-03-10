# ¿Qué es Azure Storage?
Azure seleccionó cuatro servicios de datos y los agrupó bajo el nombre Azure Storage: Azure Blobs, Azure Files, Azure Queues y Azure Tables. 

## _¿Qué es una cuenta de almacenamiento?_
- Es un contenedor que agrupa un conjunto de servicios de almacenamiento de Azure. 
- Solo se pueden incluir servicios de datos de Azure Storage (Azure Blobs, Azure Files, Azure Queues y Azure Tables).
- La combinación de servicios de datos en una cuenta de almacenamiento permite administrarlos como grupo.
- La configuración que especifique al crear la cuenta o cualquier opción que cambie tras la creación, se aplica a todo el contenido de la cuenta.
- Al eliminar la cuenta de almacenamiento se eliminan todos los datos que contiene.
- Una cuenta de almacenamiento es un recurso de Azure y se incluye en un grupo de recursos.  
- Otros servicios de datos de Azure, como Azure SQL y Azure Cosmos DB, se administran como recursos de Azure independientes y no se pueden incluir en una cuenta de almacenamiento. 

### Configuración de las cuentas de almacenamiento
Una cuenta de almacenamiento define una directiva que se aplica a todos los servicios de almacenamiento de esta:
- Suscripción: suscripción a la que se facturan los servicios de la cuenta.
- Location: centro de datos en el que se almacenan los servicios de la cuenta.
- Rendimiento: determina los servicios de datos que se pueden tener en la cuenta de almacenamiento y el tipo de discos físicos que se usan para almacenar los datos. Estándar: permite tener cualquier servicio de datos (blobs, archivos, colas, tablas) y usa unidades de disco magnéticas. Premium: incorpora servicios adicionales para almacenar datos.
- Replicación: determina la estrategia que se usa para realizar copias de los datos, con el fin de protegerlos contra errores de hardware o desastres naturales. 
- Nivel de acceso: controla la rapidez de acceso a los blobs en esta cuenta de almacenamiento. El nivel Frecuente es más rápido que el nivel Esporádico, pero el costo también es mayor. Esto se aplica solo a los blobs.
- Se requiere transferencia segura: característica de seguridad que permite HTTPS o HTTP.
- Redes virtuales: característica de seguridad que permite recibir solicitudes de acceso de entrada solo desde las redes virtuales que especifique.

## _Diversidad de los datos_
Las organizaciones suelen generan datos que difieren en el lugar de consumo, el grado de confidencialidad, el grupo que paga las facturas, etc. La diversidad en cualquiera de estos vectores puede derivar en la necesidad de distintas cuentas de almacenamiento. 

## _Susceptibilidad a los costos_
Una cuenta de almacenamiento en sí no supone costos económicos; sin embargo, la configuración que se elija para la cuenta afecta al costo de los servicios de esta. El almacenamiento con redundancia geográfica cuesta más que el almacenamiento con redundancia local. El nivel de acceso frecuente y el rendimiento Premium aumentan el costo de los blobs.
Para reducir los costos, puede usar varias cuentas de almacenamiento. Por ejemplo, puede dividir los datos en dos categorías: críticos y no críticos.

## _Elección de la configuración de la cuenta_
Las tres opciones de configuración que se aplican a la cuenta afectana la manera  de administrar la cuenta y al costo de los servicios que incluye:
- Nombre: Cada cuenta de almacenamiento tiene un nombre. El nombre debe ser único de forma global dentro de Azure, usar solo números y letras minúsculas, y debe tener entre 3 y 24 caracteres.
- Modelo de implementación: Es el sistema que Azure utiliza para organizar los recursos. Azure proporciona dos modelos de implementación:
    - Resource Manager: modelo actual que usa Azure Resource Manager API.
    - Clásico: oferta heredada que usa Azure Service Management API.
La característica clave que distingue a uno del otro reside en la compatibilidad con las agrupaciones. El modelo de Resource Manager agrega el concepto de grupo de recursos.

## _Tipo de cuenta_
- StorageV2 (v2 de uso general): oferta actual, compatible con todos los tipos de almacenamiento y las características más recientes.
- Storage (uso general v1): tipo heredado que admite todos los tipos de almacenamiento, pero es posible que no todas las características.
- Blob Storage: tipo heredado que solo permite blobs en bloques y blobs en anexos.

Microsoft recomienda el uso de la opción V2 de uso general para las cuentas de almacenamiento nuevas.

## _Elección de una herramienta de creación de cuentas_
Las herramientas disponibles son las siguientes:
Azure Portal
CLI de Azure (interfaz de la línea de comandos)
Azure PowerShell
Bibliotecas cliente de administración

### Elección de la herramienta
Las cuentas de almacenamiento se suelen basar en un análisis de los datos. En consecuencia, la creación de cuentas de almacenamiento suele ser una operación única que se realiza al principio del proyecto. Para las actividades que se realizan una sola vez, el portal es la opción más utilizada. En los casos excepcionales que requieran automatización, se elige entre una API de programación o una solución de scripting. En general, los scripts se crean más rápidamente y se mantienen más fácilmente, ya que no requieren entorno de desarrollo integrado, paquetes NuGet ni pasos de compilación.