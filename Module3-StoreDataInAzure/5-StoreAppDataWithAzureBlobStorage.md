# Almacenamiento de datos de aplicaciones con Azure Blob Storage

## _Blob Storage_
Los blobs brindan almacenamiento de archivos en la nube y una API que permite compilar aplicaciones para acceder a los datos.

Azure Blob Storage es no estructurado, lo que significa que no hay ninguna restricción sobre los tipos de datos que puede contener, por lo que un blob puede contener un PDF, JPG,, JSON, VIdeo, etc.

Los blobs no son adecuados para datos estructurados porque su latencia es mayor que la memoria y disco local y no tiene indexacion para hacer mas eficaces la ejecución de consultas. Pero los blobs pueden usarse junto a una base de datos estructurada en forma de guardar una url o identificador del blob en una de las columnas.

## _Storage Account, Contenedores y Metadatos
En el Blob Storage, los blobs se encuentran dentro de un contenedor de blobs. Un Storage account puede almacenar blobs ilimitados en un contenedor y tener un número ilimitado de contenedores. 

Los contenedores y blobs admiten metadatos en format de pares de cadena clave-valor, lo que sirve para tener una descripción del blob por ejemplo.

---

# Diseño de una estrategia de organización de almacenamiento
Al diseñar una aplicación que necesita almacenar los datos, es importante pensar en cómo la aplicación va a organizarlos en blobs, contenedores y cuentas de almacenamiento.

## _Cuentas de almacenamiento_
Usar una sola Storage Account puede ser suficiente para organizar blobs como se desee pero se debería usar más cuentas de almacenamiento para separar costos y controlar el accesos.

## _Limitaciones sobre nomenclatura_
Los nombres de contenedores y blobs deben seguir una serie de reglas, como las limitaciones de longitud y las restricciones de caracteres.

## _Acceso público y contenedores como límites de seguridad_
De forma predeterminada, todos los blobs requieren autenticación para acceder. Sin embargo, los contenedores individuales pueden configurarse para permitir la descarga pública de sus blobs sin autenticación. Los blobs de un contenedor configurado con acceso público los puede descargar cualquier persona que conozca las URL de almacenamiento sin ningún tipo de autenticación o auditoría. No se debe colcar los datos de blob en un contenedor público si no se desea compartirlos públicamente.



