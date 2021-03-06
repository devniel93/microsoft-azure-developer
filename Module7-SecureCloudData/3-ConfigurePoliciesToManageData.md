# Configuración de directivas de seguridad para administrar datos
Clasificar los datos e identificar cuáles son sus necesidades de protección de datos ayuda a seleccionar la solución en la nube adecuada. La clasificación de datos permite a las organizaciones encontrar optimizaciones de almacenamiento que podrían no ser posibles cuando todos los datos tienen asignado el mismo valor. Ademas, puede ofrecer ventajas como la eficiencia del cumplimiento, mejores formas de administrar los recursos de la organización y una migración a la nube más sencilla

## _Clasificación de los datos en reposo, en proceso y en tránsito_
Los datos digitales siempre se encuentran en uno de estos tres estados: en reposo, en proceso y en tránsito.

Los datos clasificados como confidenciales deben mantener su confidencialidad en cada estado.

Los datos pueden ser además estructurados o no estructurados. Los procesos típicos de clasificación de los datos estructurados que se encuentran en bases de datos y hojas de cálculo son de menor complejidad, y se dedica menos tiempo a administrarlos en comparación con los datos no estructurados, como documentos, código fuente y correos electrónicos.

La clasificación de datos ayuda a garantizar que los datos confidenciales o sensibles se administran con mayor supervisión que los recursos de datos considerados como de distribución pública.

### Protección de los datos en reposo
El cifrado de datos en reposo es un paso obligatorio en lo que respecta a la privacidad de los datos, el cumplimiento y la soberanía de los datos.

- Para el cifrado de discos:
Usar Microsoft Azure Disk Encryption, que permite a los administradores de TI cifrar discos de infraestructura como servicio (IaaS) de Windows y discos de máquina virtual IaaS de Linux. Disk Encryption combina la característica BitLocker estándar del sector y la característica DM-Crypt de Linux para facilitar el cifrado de volumen en el sistema operativo y los discos de datos. 

### Protección de los datos en tránsito
uesto que los datos se desplazan entre muchas ubicaciones, la recomendación general es utilizar siempre los protocolos SSL/TLS para intercambiar datos entre diferentes ubicaciones.

Es posible que desee aislar el canal de comunicación completo entre infraestructura local y en la nube mediante una VPN.

Al enviar tráfico cifrado entre una instancia de Azure Virtual Network y una ubicación local a través de Internet público, use Azure VPN Gateway.

- Para proteger el acceso a una red virtual de Azure desde varias estaciones de trabajo situadas en el entorno local usar VPN de sitio a sitio.
- Para proteger el acceso a una red virtual de Azure desde una estación de trabajo situada en el entorno locar usar VPN de punto a sitio.
- Para mover los conjuntos de datos grandes a través de un vínculo de red de área extensa (WAN) de alta velocidad dedicado usar Azure ExpressRoute y cifrar los datos en el nivel de aplicación mediante SSL/TLS u otros protocolos para lograr una mayor protección.
- Interactuar con Azure Storage a través de Azure Portal

## _Detección de datos_
La clasificación y detección de datos facilitan funcionalidades avanzadas integradas en Azure SQL Database para detectar, clasificar, etiquetar y proteger la información confidencial (como los datos personales o la información de carácter empresarial o financiero).

La búsqueda y clasificación de estos datos puede servircomo infraestructura para:
- Ayudar a cumplir los requisitos de cumplimiento de normas y los estándares relacionados con la privacidad de datos
- Abordar diversos escenarios de seguridad, como la supervisión (auditoría) y las alertas relacionadas con accesos anómalos a información confidencial
- Controlar el acceso y mejorar la seguridad de las bases de datos que contienen información altamente confidencial

La clasificación y detección de datos forma parte de la oferta de Advanced Data Security. Dicha oferta es un paquete unificado de funcionalidades avanzadas de seguridad de Microsoft SQL Server. 

### Pasos de detección, clasificación y etiquetado
La clasificación tiene dos atributos de metadatos:
- Etiquetas: son los atributos de clasificación principales, que se usan para definir el nivel de confidencialidad de los datos almacenados en la columna.
- Tipos de información: aportan una granularidad extra en el tipo de datos almacenados en la columna.

La personalización de la taxonomía de clasificación se realiza en una ubicación central para todo el inquilino de Azure: Azure Security Center.

Como parte de la administración de directivas de Azure Information Protection, puede definir etiquetas personalizadas, clasificarlas y asociarlas con un conjunto selecto de tipos de información. También puede agregar sus propios tipos de información personalizados y configurarlos con patrones de cadena, que se agregan a la lógica de detección para identificar este tipo de datos en las bases de datos. 

1. En Azure Portal > Crear recurso > Base de datos SQL
2. Ingresar nombre de BD, suscripcion, RG, no usar grupo elastico de SQL
3. En servidor > Crear nuevo > Ingresar nombre, usuario admin, password, ubicacion
4. Seleccionar Configuracion Adicional > Origen de Datos > Usar datos existentes > seleccionar Muestra
4. En Habilitar Advanced Data Security > seleccionar Iniciar prueba gratuita
5. Revisar y crear > crear

## _SQL Information Protection (SQL IP)_
SQL IP incluye un conjunto de servicios avanzados y funcionalidades de SQL que forman un nuevo paradigma de protección de la información en SQL destinado a proteger los datos

- Auditorías de Azure SQL: realizan un seguimiento de los eventos de una base de datos y los escriben en un registro de auditoría en la cuenta de Azure Storage, el área de trabajo de Log Analytics o el centro de eventos.
- Detección y clasificación de datos: se integran en Azure SQL Database, Azure SQL Managed Instance y Azure Synapse Analytics. Ofrece funcionalidades avanzadas para detectar, clasificar, etiquetar e informar de los datos confidenciales de las bases de datos.
- Enmascaramiento dinámico de datos: Azure SQL Database, Azure SQL Managed Instance y Azure Synapse Analytics son compatibles con el enmascaramiento dinámico de datos, el cual limita la exposición de información confidencial ocultándolos a los usuarios sin privilegios.
- Security Center: examina las bases de datos y ofrece recomendaciones para mejorar la seguridad. También permite configurar y supervisar alertas de seguridad.
- Cifrado de datos transparente: esta tecnología cifra sus bases de datos, copias de seguridad y registros en reposo sin realizar cambios en la aplicación. Para habilitar el cifrado, vaya a cada base de datos.

### Clasificación de una instancia de bases de datos SQL
1. En Azure Portal > Azure SQL Database > Seguridad > seleccionar Security Center
2. Habilitar Advanced Data Security
3. Seleccionar Securty Center > Deteccion y clasifificacion de datos > Aceptar las recomendaciones seleccionadas > Guardar 
4. Revisar en la seccion de Deteccion y clasificacion de datos el resumen del estado de clasificacion y una lista con las columnas clasificadas

### Clasificación de su instancia de bases de datos SQL
Un aspecto importante del paradigma de protección de la información es la capacidad de supervisar el acceso a información confidencial. Azure SQL Database Auditing se ha mejorado para incluir un nuevo campo en el registro de auditoría. El campo data_sensitivity_information registra las clasificaciones de confidencialidad (etiquetas) de los datos reales devueltos por la consulta.

---

## _Exploración de la recuperación, retención y eliminación de datos_
Una vez examinados y clasificados los datos de una organización, lo siguiente es revisar el tiempo durante el que se van a conservar los datos. La recuperación y eliminación de datos son un aspecto esencial de la administración de los recursos de datos. Una directiva de retención de datos define los principios de recuperación y eliminación de datos, y se aplica de la misma manera que la reclasificación de datos. 

La definición de una directiva de datos confidenciales puede garantizar que los datos se almacenen y eliminen de acuerdo con los procedimientos recomendados. 

### Almacenamiento inmutable y retención de datos
El almacenamiento inmutable de Azure Blob Storage permite a los usuarios almacenar los datos críticos de la empresa en un estado WORM (escribir una vez, leer muchas). En este estado, los usuarios no pueden borrar ni modificar los datos durante el intervalo de tiempo especificado por el usuario. Los blobs se pueden crear y leer, pero no modificar ni eliminar, durante el periodo de retención.

El almacenamiento inmutable permite:
- Compatibilidad con directivas de retención con duración definida
- Compatibilidad con directivas de suspensión legal:
- Compatibilidad con todos los niveles de blobs
- Configuración en el nivel de contenedor
- Compatibilidad con el registro de auditoría

### Retenciones legales
Cuando hay expectativas razonables de litigio, se exige a las organizaciones conservar la información almacenada electrónicamente. Estas expectativas suelen existir antes de que se conozcan los detalles del caso y la preservación suele ser amplia. Si se establece una suspensión legal, tanto los blobs nuevos como los existentes permanecen en estado inmutable hasta que se elimine dicha suspensión.

---

## _Definición de la soberanía de datos_
La información digital siempre está sujeta a las leyes del país o región donde se almacenan. Este concepto se conoce como soberanía de los datos. Muchos de los problemas en torno a la soberanía de los datos tienen que ver con la puesta en marcha de regulaciones de privacidad y los esfuerzos por evitar que los datos que se almacenan en un país extranjero sean requeridos mediante citación por el gobierno del país o la región donde se hospedan.

### Regiones emparejadas
Azure funciona en varias ubicaciones geográficas del mundo. Una ubicación geográfica de Azure es un área definida del mundo que contiene al menos una región de Azure. Una región de Azure es un área que contiene uno o varios centros de datos. Cada región de Azure se empareja con otra región de la misma zona geográfica, conformando lo que se denomina par de regiones. La excepción es el Sur de Brasil, ya que se trata de una región emparejada con otra que se encuentra fuera de su ubicación geográfica.

En los pares de regiones, Azure serializa las actualizaciones de la plataforma (o el mantenimiento planeado), de forma que solo se actualiza una región de cada vez. Si se produce una interrupción que afecta a varias regiones, se dará prioridad a la recuperación de una de las regiones de cada par.

### Clave de número de actividades entre regiones
- Azure Compute (IaaS): para asegurarse de que haya recursos disponibles en otra región durante un desastre, se deben aprovisionar más recursos de proceso de antemano. 
- Azure Storage: el almacenamiento con redundancia geográfica (GRS) los datos se replican automáticamente tres veces dentro de la región primaria y tres veces en una región emparejada. 
- Azure SQL Database: con la replicación geográfica de Azure SQL Database, puede configurar la replicación asincrónica de las transacciones en cualquier región del mundo.
- Azure Resource Manager: proporciona de forma inherente aislamiento lógico de los componentes entre regiones. Esto significa que es menos probable que los errores lógicos de una región afecten a otras regiones.

### Ventajas de la clave de número de regiones emparejadas de Azure
- Aislamiento físico
- Replicación proporcionada por la plataforma
- Orden de recuperación de región
- Actualizaciones en secuencia
- Residencia de datos