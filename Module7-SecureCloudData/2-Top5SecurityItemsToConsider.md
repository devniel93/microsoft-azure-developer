# 5 elementos de seguridad principales que deben tenerse en cuenta antes de pasar a producción
Uno de los mayores problemas de la seguridad es poder ver todas las áreas que hay que proteger y encontrar los puntos vulnerables antes que los piratas informáticos. Azure ofrece Azure Security Center, un servicio que facilita esto en gran medida.

### ¿Qué es Azure Security Center?
Es un servicio de supervisión que proporciona protección contra amenazas en todos los servicios, tanto en Azure como en el entorno local.

- Proporciona recomendaciones de seguridad en función de sus configuraciones, recursos y redes.
- Supervisa la configuración de seguridad de las cargas de trabajo locales y en la nube, y aplicar automáticamente la seguridad necesaria a los nuevos servicios cuando se conectan.
- Supervisar continuamente todos los servicios y realizar evaluaciones de seguridad automáticas para identificar posibles puntos vulnerables antes de alguien los aproveche.
- Usar aprendizaje automático para detectar y bloquear la instalación de malware en sus servicios y máquinas virtuales. 
- Analizar e identificar posibles ataques entrantes y ayudar a investigar amenazas y otras actividades posteriores a una brecha que pudieran haberse producido.
- Control de acceso Just-In-Time para los puertos para asegurarse de que la red solo permite el tráfico que necesita y reducir la superficie expuesta a ataques.

* ASC forma parte de las recomendaciones de Center for Internet Security (CIS).

## _Activación de Azure Security Center_
El nivel gratuito ofrece recomendaciones, evaluaciones y directivas de seguridad mientras que el nivel estándar proporciona un sólido conjunto de características, incluida la inteligencia de amenazas.

1. En Azure Portal > seleccionar Azure Security Center > Todos los servicioc > Security Center 
2. En Directiva y cumplimiento > Seleccionar Cobertura. Se mostraran los elementos de suscripcion que estan cubiertos o no por ASC.
3. Seleccionar el boton Actualizar ahora para habilitar ASC en todos los recursos  de la suscripcion.

## _Desactivación de Azure Security Center_
1. En Azure Portal > seleccionar Azure Security Center > Todos los servicioc > Security Center 
2. Seleccionar Directiva de Seguridad > Editar Configuracion
3. Seleccionar Plan de Tarifa > hacer clic en el cuadro Gratis 
4. Guardar

--- 

## _Entradas y salidas_
El punto débil de seguridad más frecuente de las aplicaciones de hoy en día es no procesar correctamente los datos recibidos de orígenes externos, especialmente las entradas de usuario.

### ¿Cuándo hay que validar los datos de entrada?
Siempre. Se deben validar todos los datos de entrada de la aplicación. Esto incluye los parámetros en la dirección URL, las entradas de usuario, los datos de la base de datos, los datos de una API y todo lo que se pase que un usuario pudiera manipular potencialmente. Use siempre listas de permitidos para aceptar solo datos de entrada "buenos conocidos", en lugar de listas de no permitidos (que buscan específicamente datos de entrada incorrectos), porque es imposible crear una lista completa con todos los datos de entrada potencialmente peligrosos.

### Codificar siempre los datos de salida
Todos los datos de salida que presente visualmente o en un documento deberán codificarse e incluir caracteres de escape. Este principio de diseño permite asegurarse de que todo se muestra como salida y que no se interpreta involuntariamente como elementos ejecutables, que es en lo que consiste otra técnica de ataque común conocida como "scripting entre sitios" (XSS).

---

## _Secretos de Key Vault_
Los secretos no son secretos si se comparten con todos. Almacenar elementos confidenciales como cadenas de conexión, tokens de seguridad, certificados y contraseñas en el código es simplemente invitar a alguien a tomarlos y usarlos para algo distinto de lo que se pretendía. 

### ¿Qué es Azure Key Vault?
Es un almacén de secretos: un servicio centralizado en la nube para almacenar secretos de aplicación. Key Vault ayuda a mantener seguros los datos confidenciales al mantener los secretos de aplicación en una sola ubicación central y proporcionar acceso seguro, control de permisos y registro de acceso.

### ¿Por qué usar un almacén de claves para los secretos?
La administración de claves y el almacenamiento de secretos puede ser algo complicado y propenso a errores cuando se realiza manualmente. La rotación manual de certificados significa potencialmente prescindir de ellos durante algunas horas o días.

--- 

## Actualizaciones del marco (framework)
Elegir el marco de trabajo para el desarrollo de software es una decisión importante, no solo desde el punto de vista del diseño y la funcionalidad, sino también desde el punto de vista de la seguridad. Elegir un marco de trabajo con características de seguridad modernas y mantenerlo actualizado es una de las mejores formas de asegurarse de que sus aplicaciones son seguras.

### Importancia de la elección del marco de trabajo
Los marcos de trabajo anteriores tendían a ser reemplazados o a terminar por desvanecerse. Aunque tenga una fantástica experiencia con muchas aplicaciones escritas en un marco anterior, es mejor que elija una biblioteca moderna que tenga las características que necesita. Los marcos modernos suelen basarse en las lecciones aprendidas en las iteraciones anteriores, por lo que su elección para las nuevas aplicaciones es una forma de minimizar la exposición a las amenazas. Si se detecta una vulnerabilidad en el marco antiguo en el que estén escritas las aplicaciones heredadas, eso supone una aplicación más de la que ocuparse.

### Actualización continua del marco
Los marcos de desarrollo de software, como Java Spring y .NET Core publican actualizaciones y nuevas versiones con regularidad. Estas actualizaciones incluyen nuevas características, eliminación de características antiguas y, a menudo, correcciones de seguridad o mejoras.

### ¿Cómo actualizar el marco de trabajo?
Las bibliotecas más especializadas, como los marcos de JavaScript o los componentes de .NET, se pueden actualizar con un administrador de paquetes. NPM y Webpack son opciones populares para proyectos web y son compatibles con la mayoría de los IDE o herramientas de compilación. En .NET, se usa NuGet para administrar las dependencias de los componentes. 
* Si usa Azure para hospedar sus aplicaciones web, Security Center le avisará en caso de que sus marcos estén obsoletos en la pestaña de recomendaciones.

## _Aprovechamiento de las ventajas de la seguridad integrada_
No usar nunca su propio método de seguridad si hay una técnica o funcionalidad estándar integrada. Se debe confiar en los algoritmos y flujos de trabajo ya probados porque numerosos expertos los someten a examen, los analizan y los refuerzan para garantizar que son confiables y seguros.

---

## _Dependencias seguras_
Un porcentaje elevado del código presente en las aplicaciones modernas se compone de las bibliotecas y las dependencias elegidas por el desarrollador. Esto es una práctica común que ahorra tiempo y dinero. Pero la desventaja es que ahora es el responsable de este código, aunque otros lo han escrito, ya que lo utiliza en el proyecto. Si un investigador (o peor, un hacker) detecta una vulnerabilidad en una de estas bibliotecas de terceros, el mismo error probablemente también estará presente en su aplicación.

### Seguimiento de vulnerabilidades de seguridad conocidas
Mantener las bibliotecas y dependencias actualizadas será de ayuda, pero es una buena idea realizar un seguimiento de las vulnerabilidades identificadas que podrían afectar a la aplicación.

Mitre es una organización sin ánimo de lucro que mantiene la lista de vulnerabilidades y exposiciones comunes (https://cve.mitre.org/). Esta lista es un conjunto de vulnerabilidades de ciberseguridad conocidas en aplicaciones, bibliotecas y marcos de trabajo que se puede consultar públicamente. 

### Procedimiento para comprobar si tiene vulnerabilidades conocidas en los componentes de terceros
Se puede ejecutar las siguientes herramientas en el código base o agregarlas a la canalización de CI/CD para buscar problemas automáticamente como parte del proceso de desarrollo:
- OWASP Dependency Check, que tiene un complemento de Jenkins
- SonarQube de OWASP
- Synk, que es gratis para los repositorios de código abierto en GitHub
- Black Duck, que se usa en muchas empresas
- RubySec, una base de datos de consulta para Ruby
- Retire.js, una herramienta para comprobar si las bibliotecas de JavaScript no están actualizadas; se puede usar como un complemento para varias herramientas, incluida Burp Suite

También se pueden usar algunas herramientas creadas específicamente para análisis de código estático:
- Roslyn Security Guard
- Puma Scan
- PT Application Inspector
- Apache Maven Dependency Plugin
- Source Clear
- Sonatype
- Node Security Platform
- WhiteSource
