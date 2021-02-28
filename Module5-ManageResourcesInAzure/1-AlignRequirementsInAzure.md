# Alineación de requisitos con tipos en la nube y modelos de servicio en Azure

## _¿Qué es la informática en la nube?_
Es el aprovisionamiento de servicios y aplicaciones a petición a través de Internet. Los servidores, las aplicaciones, los datos y otros recursos se ofrecen como servicio. Puede aprovisionar los recursos informáticos rápidamente y usar el servicio con la mínima administración.

Hay tres modelos de implementación para la informática en la nube: nube pública, nube privada y nube híbrida.

## _Nube pública_
Los servicios se ofrecen a través de la red Internet pública y están disponibles para cualquiera que quiera comprarlos. Los recursos de nube, como los servidores y el almacenamiento, son propiedad de un proveedor de servicios en la nube de terceros, que los explota y los distribuye a través de Internet. Los servicios pueden ser gratuitos o venderse a petición, lo que permite a los clientes pagar solo por el uso de los ciclos de CPU, almacenamiento o ancho de banda que consumen. 

### ¿Por qué optar por la nube pública?
- Consumo de servicios a través de un modelo a petición o de suscripción: El modelo a petición o de suscripción permite pagar la parte de la CPU, el almacenamiento y otros recursos que use o reserve.

- Sin inversión inicial de hardware: No es necesario adquirir, administrar y mantener una infraestructura local de hardware y aplicaciones. El proveedor de servicios en la nube es responsable de toda la administración y el mantenimiento del sistema.

- Automatización: Aprovisionamiento rápido de los recursos de infraestructura mediante un portal web, scripts o de forma automática.

- Dispersión geográfica: Almacenamiento de los datos cerca de los usuarios o en ubicaciones donde se necesiten sin tener que mantener centros de datos propios.

- Mantenimiento reducido del hardware: El proveedor de servicios es responsable del mantenimiento del hardware.

## _Nube privada_
Consta de recursos informáticos que determinados usuarios de una empresa u organización usan en exclusiva. Puede estar ubicada físicamente en el centro de datos local de la organización o estar hospedada por un proveedor de servicios de terceros. La organización es responsable de la compra, la configuración y el mantenimiento del hardware. La comunicación entre los sistemas suele establecerse en la infraestructura de red que la empresa posee y mantiene.

### ¿Por qué optar por la nube privada?
- Entorno ya existente: Entorno operativo existente que no se puede replicar en la nube pública. Una gran inversión en hardware y empleados con experiencia en soluciones. Una organización grande puede transformar sus recursos informáticos en un producto de consumo masivo.

- Aplicaciones heredadas: Aplicaciones heredadas críticas para la empresa que no se pueden reubicar físicamente con facilidad.

- Seguridad y soberanía de los datos: Las fronteras políticas y los requisitos legales pueden dictar dónde pueden existir físicamente los datos.

- Certificación de cumplimiento / certificación: Cumplimiento de normas HIPAA o PCI. Centro de datos local certificado.

## _Nube híbrida_
Es un entorno informático que combina una nube pública y una nube privada, lo que permite compartir datos y aplicaciones entre ellas. La informática en la nube híbrida ofrece a las empresas la posibilidad de escalar sin problemas su infraestructura local hasta la nube pública para controlar cualquier desbordamiento. Contribuye a eliminar la necesidad de realizar gastos de capital anticipados para afrontar aumentos de demanda a corto plazo. Las compañías solo pagan los recursos que utilizan temporalmente en lugar de tener que comprar, programar y mantener recursos y equipos adicionales que podrían permanecer inactivos durante largos períodos de tiempo. La integración se realiza generalmente a través de una VPN segura entre los proveedores de nube como Azure y centros de datos locales.

### ¿Por qué optar por la nube híbrida?
- Inversión en hardware existente: Por motivos empresariales hay que usar el entorno operativo y el hardware actuales.

- Requisitos reglamentarios: El reglamento exige que los datos permanezcan en una ubicación física.

- Entorno operativo único: La nube pública no puede replicar el entorno operativo heredado.

- Migración: Las cargas de trabajo se mueven a la nube a lo largo del tiempo.

## _Modelos de servicio en la nube_

Infraestructura como servicio (IaaS):
proporciona la infraestructura informática instantánea que puede aprovisionar y administrar a través de Internet.

- Plataforma como servicio (PaaS):
proporciona entornos de desarrollo e implementación listos para usar que puede utilizar para proporcionar servicios en la nube propios.

- Software como servicio (SaaS):
proporciona aplicaciones a través de Internet como un servicio basado en web.

### Infraestructura como servicio IaaS
Es una infraestructura informática instantánea que se aprovisiona y administra a través de Internet. IaaS permite escalar rápidamente los recursos para satisfacer la demanda y pagar solo por lo que se usa. Evita el gasto y la complejidad que implica comprar y administrar sus propios servidores físicos y otra estructura de centro de datos.

Escenarios comunes para usar IaaS:

- Hospedaje de sitios web: Si quiere mayor control del hospedaje de un sitio web, ejecutar sitios web mediante IaaS puede ser una mejor opción que el hospedaje web tradicional.

- Aplicaciones web: IaaS proporciona toda la infraestructura para admitir aplicaciones web, incluidos los servidores de aplicaciones, web y almacenamiento, además de los recursos de red. Las organizaciones pueden implementar rápidamente aplicaciones web en IaaS y escalar y reducir la infraestructura cuando no sea posible predecir la demanda de las aplicaciones.

- Almacenamiento, copia de seguridad y recuperación: La administración de almacenamiento puede ser compleja y requerir una gran inversión de capital y personal capacitado para administrar los datos y cumplir los requisitos legales y de cumplimiento. IaaS puede ayudar a simplificar el planeamiento, la administración, las demandas impredecibles y las necesidades de almacenamiento en constante crecimiento.

- Informática de alto rendimiento: Si tiene una carga de trabajo que requiere informática de alto rendimiento, puede ejecutarla en la nube para evitar el costo por adelantado del hardware y solo pagar por el uso cuando sea necesario.

- Análisis de macrodatos: Si tiene conjuntos de datos de gran tamaño que contienen patrones, tendencias y asociaciones potencialmente útiles, IaaS puede proporcionar la capacidad de procesamiento para extraer conjuntos de datos con el fin de buscar patrones.

Ventajas:

- Elimina los gastos de capital y reduce los costos continuos: IaaS evita el gasto inicial de configurar y administrar un centro de datos in situ, por lo que es una opción económica para empresas emergentes y empresas que prueban ideas nuevas. 

- Mejora la continuidad empresarial y la recuperación ante desastres: Gracias a los SLA, IaaS puede disminuir este costo y acceder a las aplicaciones y los datos como de costumbre durante un desastre o una interrupción.

- Permite responder rápidamente a la cambiante situación empresarial: IaaS permite escalar verticalmente los recursos para dar cabida a los aumentos en la demanda de su aplicación y luego volver a reducirlos verticalmente cuando la actividad disminuye para ahorrar dinero. 

- Permite aumentar la estabilidad, confiabilidad y compatibilidad: Con IaaS, no es necesario mantener ni actualizar hardware, ni tampoco solucionar problemas con los equipos. 

### Plataforma como servicio PaaS
Es un entorno completo de desarrollo e implementación en la nube. Con PaaS, puede compilar e implementar todo, desde aplicaciones sencillas basadas en la nube a aplicaciones empresariales sofisticadas y habilitadas para la nube. PaaS admite todo el ciclo de vida de una aplicación web: compilación, prueba, implementación, administración y actualización. PaaS elimina la necesidad de administrar las licencias de software, el software intermedio y la infraestructura de los servicios

Escenarios comunes:
- Marco de desarrollo: los desarrolladores pueden usan para desarrollar o personalizar aplicaciones basadas en la nube. Se incluyen características de la nube, como escalabilidad, alta disponibilidad y funcionalidad multiinquilino, lo que permite reducir la cantidad de codificación que deben realizar los desarrolladores.

- Análisis o inteligencia empresarial: Las herramientas de análisis que se proporcionan como servicio permiten analizar y extraer datos. 

Ventajas:

- Menor tiempo de desarrollo: Las herramientas de desarrollo de PaaS pueden disminuir el tiempo de desarrollo de las aplicaciones nuevas. Los desarrolladores pueden usar componentes de aplicación codificados previamente e insertados en la plataforma. Pueden brindar al equipo de desarrollo funcionalidades nuevas sin que sea necesario agregar personal con las aptitudes necesarias.

- Desarrollo para varias plataformas: Algunos proveedores de servicio ofrecen opciones de desarrollo para varias plataformas, como equipos de escritorio, dispositivos móviles y exploradores, que permite que desarrollar aplicaciones multiplataforma sea más rápido y sencillo.

- Uso económico de herramientas sofisticadas: Un modelo de pago por uso permite que individuos u organizaciones usen sofisticadas herramientas de análisis e inteligencia empresarial y software de desarrollo que no podrían comprar directamente.

- Compatibilidad con equipos de desarrollo distribuidos geográficamente: Como se accede por Internet al entorno de desarrollo, los equipos de desarrollo pueden trabajar conjuntamente en proyectos incluso cuando los miembros de los equipos se encuentran en ubicaciones remotas.

- Administración eficaz del ciclo de vida de la aplicación: PaaS proporciona todas las funcionalidades necesarias para admitir todo el ciclo de vida de una aplicación web: compilación, prueba, implementación, administración y actualización dentro del mismo entorno integrado.

### Software como servicio SaaS
Permite que los usuarios se conecten y usen aplicaciones basadas en la nube a través de Internet.Algunos ejemplos comunes son el correo electrónico, el calendario y las herramientas de oficina como Microsoft 365. Toda la infraestructura subyacente, el software intermedio, el software de aplicación y los datos de aplicación se encuentran en el centro de datos del proveedor de servicios. El proveedor de servicios administra el hardware y el software y, como el acuerdo de servicio adecuado, garantizará la disponibilidad y la seguridad de la aplicación y también de los datos.

Ventajas:

- Obtención de acceso a aplicaciones sofisticadas: Para proporcionar aplicaciones SaaS a los usuarios, no tiene que comprar, instalar, actualizar ni mantener hardware, software intermedio ni software alguno. Con SaaS, incluso las aplicaciones empresariales sofisticadas, como ERP y CRM, son accesibles para las organizaciones que no cuentan con los recursos para comprar, implementar ni administrar la infraestructura y el software que se necesita. Solo se paga lo que se usa. 

- Uso de software cliente gratis: Los usuarios pueden ejecutar la mayoría de las aplicaciones SaaS directamente desde el explorador web sin tener que descargar ni instalar software. 

- Acceso a datos de aplicación desde cualquier lugar: Con los datos almacenados en la nube, los usuarios pueden acceder a su información desde cualquier dispositivo móvil o equipo conectado a Internet.