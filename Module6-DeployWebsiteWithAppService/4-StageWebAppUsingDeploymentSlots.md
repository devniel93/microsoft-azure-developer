# Ensayo de la implementación de una aplicación web para pruebas y reversión mediante ranuras de implementación de App Service

## _Uso de una ranura de implementación
Dentro de una aplicación web única de Azure App Service puede crear varias ranuras de implementación. Cada ranura es una instancia independiente de esa aplicación web y tiene un nombre de host independiente.

Una ranura es el espacio de producción. Puede usar ranuras adicionales para hospedar versiones nuevas de la aplicación web. En estos casos, puede ejecutar pruebas como pruebas de integración, pruebas de aceptación y las pruebas de capacidad.

A diferencia de una implementación de código, un intercambio de ranuras es instantáneo. Cuando se intercambian ranuras, se intercambian los nombres de host de las ranuras y se envía de inmediato el tráfico de producción a la versión nueva de la aplicación. 

Las ranuras de implementación solo están disponibles cuando la aplicación web usa un plan de App Service en los niveles Estándar, Premium o Aislado. 

### Evita el arranque en frío durante los intercambios
Muchas de las tecnologías que los desarrolladores usan para crear aplicaciones web requieren que la compilación final y otras acciones se realicen en el servidor antes de que se pueda entregar una página al usuario. 

El retraso inicial se denomina arranque en frío. Puede evitar un arranque en frío mediante el uso de intercambios de ranuras para implementarse durante la producción. Cuando cambia una ranura a producción, se "prepara" la aplicación porque la acción envía una solicitud a la raíz del sitio. 

## _Creación de una ranura de implementación_
1. En Azure Portal > seleccionar Deplyment Slot > Add Slot
2. Ingresar nombre y elegir si se desea clonar de otra ranura. Se puede clonar solo la configuracion mas no el contenido. Para implementar contenido se puede usar git para implementar.
3. Seleccionar Agregar para que se cree la nueva ranura.