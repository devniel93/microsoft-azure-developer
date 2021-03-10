# Seleccion de un enfoque de almacenamiento de datos en Azure

## _Clasificación de los datos_
En un negocio, puede haber diferentes tipos de datos. Cada tipo de datos puede beneficiarse de una solución de almacenamiento diferente.

### Datos estructurados
Los datos estructurados, a veces denominados datos relacionales, son datos que se ajustan a un esquema estricto, por lo que todos los datos tienen los mismos campos o propiedades.

### Datos semiestructurados
- Están menos organizados que los estructurados y no se almacenan en formato relacional, dado que los campos no encajan fácilmente en tablas, filas y columnas.
- Contienen etiquetas que hacen evidentes la organización y la jerarquía de los datos (por ejemplo, pares clave-valor).
- También se conocen como datos no relacionales o datos NoSQL.
- La expresión y la estructura de los datos de este estilo se definen mediante un lenguaje de serialización.
- Formatos comunes: hay tres lenguajes de serialización comunes: XML, JSON y YAML.

### Datos no estructurados
La organización de los datos no estructurados es ambigua. A menudo, los datos no estructurados se entregan en archivos, como fotos o vídeos. El propio archivo de vídeo puede tener una estructura general e incluir metadatos semiestructurados, pero los datos que forman el vídeo en sí mismo no están estructurados. 
Ejemplos de datos no estructurados son:
- Archivos multimedia, como fotos, vídeos y archivos de audio
- Archivos de Office, como documentos de Word
- Archivos de texto
- Archivos de registro

---

## _¿Qué es una transacción?_
Es un grupo lógico de operaciones de base de datos que se ejecutan juntas. Las transacciones a menudo se definen mediante un conjunto de cuatro requisitos, que se conocen como garantías ACID:
- La atomicidad significa que una transacción debe ejecutarse exactamente una vez y debe ser atómica. O se realiza el trabajo en su totalidad, o no se realiza. Las operaciones implicadas en una transacción suelen compartir una intención común y son interdependientes.
- La coherencia garantiza que los datos sean coherentes tanto antes como después de la transacción.
- El aislamiento garantiza que una transacción no se vea afectada por otra.
- La durabilidad significa que los cambios realizados debido a la transacción se guardan de forma permanente en el sistema. Los datos confirmados se guardan en el sistema de modo que, incluso en caso de error o reinicio del sistema, están disponibles en su estado correcto.

## _Diferencias entre OLTP y OLAP_

### OLTP (Procesamiento de transacciones en línea):
- Las bases de datos transaccionales se conocen con frecuencia como sistemas OLTP.
- Admiten muchos usuarios, tienen tiempos de respuesta rápidos y controlan grandes volúmenes de datos.
- Son altamente disponibles (lo que significa que tienen un tiempo de inactividad mínimo).
- Normalmente controlan transacciones relativamente sencillas o pequeñas

### OLAP (Procesamiento analítico en línea):
- Normalmente admiten menos usuarios.
- Tienen tiempos de respuesta más largos.
- Su disponibilidad puede ser menor 
- Por lo general controlan transacciones grandes y complejas.

## _Elección de una solución de almacenamiento en Azure_
La elección de la solución de almacenamiento correcta puede conducir a un mejor rendimiento, ahorro de costos y capacidad de administración mejorada.

## _Para el caso de negocio de Catalogo de productos_
- Clasificación de los datos: Semiestructurados debido a la necesidad de ampliar o modificar el esquema de nuevos productos.
- Latencia y rendimiento: alto rendimiento y baja latencia.
- Compatibilidad transaccional: dado que todos los datos son históricos, pero cambian, se requiere compatibilidad transaccional.

### Servicio recomendado: Azure Cosmos DB
- Azure Cosmos DB admite datos semiestructurados o datos NoSQL. 
- Azure Cosmos DB es compatible con SQL para las consultas y todas las propiedades se indexan de forma predeterminada.
- Azure Cosmos DB es compatible con ACID, las transacciones se completan según esos estrictos requisitos.
- Azure Cosmos DB permite replicar los datos en cualquier lugar del mundo.
- Se puede escalar verticalmente para controlar una mayor demanda del cliente durante las horas pico de compra, o bien reducir verticalmente durante las horas más lentas para ahorrar costos.

### ¿Por qué no otros servicios de Azure?
- Azure SQL Database sería una opción excelente para este conjunto de datos si se pudiera identificar el subconjunto de propiedades comunes en la mayoría de los productos y las propiedades de las variables que podrían no existir en algunos productos.
- A diferencia de Azure Cosmos DB, que indexa todas las propiedades de los documentos, en Azure SQL Database hay que definir de forma explícita qué propiedades de los documentos semiestructurados se deben indexar.
- Azure Cosmos DB es una opción más apropiada cuando los datos son muy variables y están muy estructurados, y no se puede predecir cuáles son las propiedades que se deben indexar.
- Otros servicios de Azure, como Azure Table Storage, Azure HBase como parte de HDInsight y Azure Cache para Redis también pueden almacenar datos NoSQL pero son limitados en los datos que indexan y la creación de consultas en campos no indexados provoca una reducción del rendimiento.

## _Para el caso de negocio de Fotografias y Videos_
- Clasificación de los datos: Datos no estructurados
- Latencia y rendimiento: Para las recuperaciones por identificador, se necesita baja latencia y alto rendimiento. Las operaciones de creación y actualización pueden tener una mayor latencia que las de lectura.
- Compatibilidad transaccional: No se requiere.

### Servicio recomendado: Azure Blob Storage
- Admite el almacenamiento de archivos, como fotos y vídeos. 
- Funciona con Azure Content Delivery Network (CDN) al almacenar en caché el contenido más usado y guardarlo en servidores perimetrales.
- Azure CDN reduce la latencia a la hora de servir esas imágenes a los usuarios.
- Con Azure Blob Storage, también puede mover las imágenes del nivel de almacenamiento de acceso frecuente al nivel de almacenamiento de acceso esporádico o de almacenamiento de archivo para reducir los costos y centrar el rendimiento en las imágenes y vídeos vistos con más frecuencia.

### ¿Por qué no otros servicios de Azure?
- Podría cargar las imágenes en Azure App Service, para que el mismo servidor que ejecuta la aplicación las suministre. Esta solución funcionaría si no tuviera muchos archivos. Pero si tiene una gran cantidad de archivos y un público global, los resultados de rendimiento serán mejores si usa Azure Blob Storage con Azure CDN.

## _Para el caso de negocio de Datos Empresariales:
- Clasificación de los datos: Estructurados.
- Operaciones: Consultas de análisis complejas de solo lectura en varias bases de datos.
- Latencia y rendimiento: Se espera algo de latencia en los resultados en función de la naturaleza compleja de las consultas.
- Compatibilidad transaccional: No se requiere.

### Servicio recomendado: Azure SQL Database
- Serán los analistas de negocios quienes consulten los datos empresariales, y es más probable que conozcan SQL.
- Se podría usar Azure SQL Database como la solución por sí misma, pero el emparejamiento con Azure Analysis Services permite a los analistas de datos crear un modelo semántico para conectarse al modelo desde cualquier herramienta de inteligencia empresarial (BI) para explorar los datos.

### ¿Por qué no otros servicios de Azure?
- Azure Synapse admite soluciones OLAP y consultas SQL. Pero los analistas de negocios tendrán que realizar consultas entre bases de datos, algo que no se admite en Azure Synapse.
- Azure SQL Database se podría usar Azure Analysis Services. Pero los analistas de negocios tienen más experiencia con SQL que con Power BI, por lo que les gustaría una base de datos que admita consultas SQL, lo que Azure Analysis Services no hace.
- Azure Stream Analytics es una excelente manera de analizar los datos y transformarlos en conclusiones accionables, pero está enfocado a datos en tiempo real que se transmiten en streaming. En este escenario, los analistas de negocios solo examinan datos históricos.