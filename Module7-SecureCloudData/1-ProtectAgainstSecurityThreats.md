# Protección frente a amenazas de seguridad en Azure

## _¿Qué es Azure Security Center?_
Es un servicio de supervisión que proporciona visibilidad del nivel de seguridad en todos los servicios, tanto en Azure como en el entorno local. El término nivel de seguridad se refiere a las directivas y a los controles de ciberseguridad, así como a la predicción, la prevención y la respuesta a las amenazas de seguridad.

Con Security Center se puede:
- Supervisar la configuración de seguridad en las cargas de trabajo locales y en la nube.
- Aplicar automáticamente la configuración de seguridad necesaria a los nuevos recursos a medida que se publican en línea.
- Proporcionar recomendaciones de seguridad basadas en las configuraciones, los recursos y las redes actuales.
- Usar el aprendizaje automático para detectar y bloquear la instalación de malware en las VM y otros recursos.
- Detectar y analizar posibles ataques entrantes e investigar amenazas y otras actividades posteriores a una brecha que pudieran haberse producido.
- Proporcionar control de acceso Just-in-Time a los puertos de red. Esto reduce la superficie expuesta a ataques al garantizar que la red solo permite el tráfico necesario en el momento en que se necesita.

### ¿Qué es la puntuación de seguridad?
Es una medida del nivel de seguridad de una organización. Se basa en controles de seguridad, o en grupos de recomendaciones de seguridad relacionadas.

La puntuación de seguridad ayuda a:
- Notificar el estado actual del nivel de seguridad de la organización.
- Mejorar el nivel de seguridad al proporcionar detectabilidad, visibilidad, orientación y control.
- Comparar con los puntos de referencia y establecer indicadores clave de rendimiento (KPI).

### Protección frente a amenazas
Security Center incluye funciones avanzadas de defensa en la nube:
- Acceso de máquina virtual Just-In-Time: bloquea el tráfico de forma predeterminada en puertos de red específicos de máquinas virtuales, pero permite el tráfico durante un tiempo especificado cuando un administrador lo solicita.
- Controles de aplicación adaptables: ontrolar qué aplicaciones se pueden ejecutar en sus máquinas virtuales. En segundo plano, Security Center usa aprendizaje automático para examinar los procesos que se ejecutan en una máquina virtual.
- Protección de red adaptable: puede supervisar los patrones de tráfico de Internet de las máquinas virtuales y compararlos con la configuración actual de los grupos de seguridad de red (NSG) de la empresa.
- Supervisión de la integridad de los archivos:  puede configurar la supervisión de los cambios en archivos importantes tanto en Windows como en Linux, la configuración del registro, las aplicaciones y otros aspectos que podrían indicar un ataque de seguridad.

### Responder a alertas de seguridad
Seuede usar Security Center para obtener una vista centralizada de todas sus alertas de seguridad y corregir una alertra de forma manual o una respuesta automatizada con un flujo de tabajo a traves de Azure Logic Apps. Se puede configurar que para que se ejecute una accion como enviar un correo o publicar un mensaje en un canal de Teams.

---

## _Detección de amenazas de seguridad y respuesta a ellas mediante Azure Sentinel_
La administración de la seguridad a gran escala puede beneficiarse de un sistema de administración de eventos e información de seguridad (SIEM) dedicado. Azure Sentinel es el sistema SIEM basado en la nube de Microsoft.

Azure Sentinel permite:
- Recopilar datos en la nube a gran escala
- Detectar amenazas no detectadas anteriormente
- Investigar amenazas con inteligencia artificial
- Responder a incidentes rápidamente

Azure Sentinel admite una serie de orígenes de datos que puede analizar en busca de eventos de seguridad:
- Conexión de soluciones de Microsoft: proporcionan integración en tiempo real para servicios como las soluciones de Protección contra amenazas de Microsoft, orígenes de Microsoft 365 (incluido Office 365), Azure Active Directory y Firewall de Windows Defender.
- Conexión con otros servicios y soluciones: AWS CloudTrail, Citrix Analytics (Security), Sophos XG Firewall, VMware Carbon Black Cloud y Okta SSO.
- Conexión con orígenes de datos estándar del sector: estándar de mensajería Formato de evento común (CEF), Syslog o la API REST.

### Detectar amenazas
Se puede usar análisis integrados como reglas personalizadas para detectar las amenazas.
- Los análisis integrados usan plantillas diseñadas por el equipo de expertos y analistas de seguridad de Microsoft que se basan en amenazas conocidas, vectores de ataque comunes y cadenas de escalado de actividades sospechosas. 
- Los análisis personalizados son reglas que se crean para buscar criterios concretos en el entorno. 

### Investigación y respuesta
Se puede investigar alertas o incidentes (un grupo de alertas relacionadas) concretos con el grafo de investigación. Tambien se puede automatizar las respuestas a las amenazas mediante `Libros de Azure Monitor`.