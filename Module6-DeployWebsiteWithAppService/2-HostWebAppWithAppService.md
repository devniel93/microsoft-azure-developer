# Hospedaje de una aplicación web con Azure App Service
Hospedar la aplicación web con Azure App Service hace que la implementación y administración de una aplicación web resulten mucho más fáciles en comparación con la administración de un servidor físico. 

## _Qué es Azure App Service_
Es una plataforma de hospedaje de aplicaciones web totalmente administrada. Esta plataforma como servicio (PaaS) que ofrece Azure le permite centrarse en el diseño y la compilación de la aplicación, mientras que Azure se encarga de la infraestructura para ejecutar y escalar las aplicaciones.

### Ranuras de implementación
Se puede crear un espacio de implementación de pruebas donde puede insertar el código para probarlo en Azure, luego se puede intercambiar la ranura de implementación de ensayo con la ranura de producción.

### Compatibilidad con la integración e implementación continuas
Azure Portal proporciona integración e implementación continuas listas para usar con Azure DevOps, GitHub, Bitbucket, FTP o un repositorio de GIT local en el equipo de desarrollo. 

### Publicación de Visual Studio integrada y publicación FTP
Visual Studio permite publicar la aplicación web en Azure mediante la tecnología Web Deploy. App Service también admite la publicación basada en FTP para flujos de trabajo más tradicionales.

### Compatibilidad integrada con la escalabilidad automática (escalabilidad horizontal en función de la carga real)
En la aplicación web se integra la capacidad de escalar o reducir verticalmente, o bien escalar horizontalmente. En la aplicación web, se puede escalar o reducir verticalmente si se aumentan o disminuyen los recursos como el número de núcleos o la cantidad de memoria RAM disponible. Y en el escalado horizontal es la capacidad de aumentar el número de instancias de máquina que ejecutan la aplicación web. 

## _Planes de App Service_
Un plan de App Service es un conjunto de recursos de servidor virtual que ejecutan aplicaciones de App Service. El tamaño de un plan (que a veces se denomina SKU o plan de tarifa) determina las características de rendimiento de los servidores virtuales que ejecutan las aplicaciones asignadas al plan.

Un solo plan de App Service puede hospedar varias aplicaciones web de App Service. Son la unidad de facturación de App Service. 