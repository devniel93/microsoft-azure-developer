# Almacenamiento de datos de aplicaciones con Azure Blob Storage

## _Blob Storage_
Los blobs brindan almacenamiento de archivos en la nube y una API que permite compilar aplicaciones para acceder a los datos.

Azure Blob Storage es no estructurado, lo que significa que no hay ninguna restricción sobre los tipos de datos que puede contener, por lo que un blob puede contener un PDF, JPG,, JSON, VIdeo, etc.

Los blobs no son adecuados para datos estructurados porque su latencia es mayor que la memoria y disco local y no tiene indexacion para hacer mas eficaces la ejecución de consultas. Pero los blobs pueden usarse junto a una base de datos estructurada en forma de guardar una url o identificador del blob en una de las columnas.

## _Storage Account, Contenedores y Metadatos
En el Blob Storage, los blobs se encuentran dentro de un contenedor de blobs. Un Storage account puede almacenar blobs ilimitados en un contenedor y tener un número ilimitado de contenedores. 

Los contenedores y blobs admiten metadatos en format de pares de cadena clave-valor, lo que sirve para tener una descripción del blob por ejemplo.