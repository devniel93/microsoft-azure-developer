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