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

---

## _Almacenamiento y administración de secretos mediante Azure Key Vault_
Azure Key Vault es un servicio en la nube centralizado para almacenar los secretos de la aplicación en una única ubicación central. Proporciona un acceso seguro a la información confidencial mediante capacidades de control de acceso y registro.

Permite:
- Administración de secretos: lmacenar de forma segura y controlar exhaustivamente el acceso a tokens, contraseñas, certificados, claves de API y otros secretos.
- Administrar claves de cifrado: Key Vault facilita la creación y el control de las claves de cifrado que se emplean para cifrar los datos.
- Administrar certificados SSL/TLS: provisionar, administrar e implementar los certificados públicos y privados de Capa de sockets seguros/Seguridad de la capa de transporte (SSL/TLS) de los recursos de Azure y los recursos internos.
- Almacenar secretos respaldados por módulos de seguridad de hardware (HSM): Estas claves y secretos se pueden proteger mediante software o mediante HSM validados por FIPS 140-2 nivel 2.

### ¿Cuáles son las ventajas de Azure Key Vault?
- Secretos de aplicación centralizados
- Secretos y claves almacenados de forma segura
- Supervisión y control de acceso
- Administración simplificada de secretos de aplicación
- Integración con otros servicios de Azure

---

## _Administración de una contraseña en Azure Key Vault_

### Creación de un Almacén de claves
1. En Azure Portal > Crear recurso > Almacen de claves  > Crear 
2. Ingresar suscripcion, RG, nombre de almacen de claves
3. Revisar y crear > Crear
* La suscripción de Azure es la única que está autorizada a acceder a este almacén. En Configuración, la característica Directivas de acceso permite configurar el acceso al almacén.

### Adición de una contraseña al almacén de claves
1. En Configuracion > seleccionar Secretos
2. Seleccionar Generar/Importar
3. Ingresar opciones de carga Manual, Nombre, Valor
4. Seleccionar Crear
5. Para ver el secret creado se puede ver en la parte de Secretos de Azure Portal o ejecutar el comando Azure CLI:
```
az keyvault secret show \
  --name MyPassword \
  --vault-name $(az keyvault list --query [0].name --output tsv) \
  --query value \
  --output tsv
```

---

## _Hospedaje de máquinas virtuales de Azure en servidores físicos dedicados mediante Azure Dedicated Host_
En Azure, las máquinas virtuales (VM) se ejecutan en hardware compartido administrado por Microsoft. Aunque el hardware subyacente se comparte, las cargas de trabajo de las máquinas virtuales están aisladas de las que ejecutan otros clientes de Azure. Algunas organizaciones deben ajustarse a un cumplimiento normativo que las obliga a ser el único cliente que usa el equipo físico en el que se hospedan sus máquinas virtuales. Azure Dedicated Host proporciona servidores físicos dedicados para hospedar las máquinas virtuales de Azure para Windows y Linux.

### ¿Cuáles son las ventajas de Azure Dedicated Host?
- Ofrece visibilidad y control sobre la infraestructura de servidor que ejecuta las VM de Azure.
- Satisface requisitos de cumplimiento mediante la implementación de las cargas de trabajo en un servidor aislado.
- Permite elegir el número de procesadores, capacidades de servidor, series de máquinas virtuales y tamaños de máquina virtual dentro del mismo host.

### Consideraciones de disponibilidad de Dedicated Host
Después de aprovisionar un host dedicado, Azure lo asigna al servidor físico en el centro de datos en la nube de Microsoft. Para lograr una alta disponibilidad, puede aprovisionar varios hosts en un grupo host e implementar las máquinas virtuales en este grupo. 

### Consideraciones sobre precios
Se cobra por host dedicado, con independencia de cuántas máquinas virtuales se implementen en él. El precio del host se basa en la familia de máquinas virtuales, el tipo (tamaño de hardware) y la región.