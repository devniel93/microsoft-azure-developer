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