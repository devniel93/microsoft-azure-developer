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

## _Configuración de la implementación de Git_
1. En Azure Portal seleccionar la aplicacion web > Implementacion > Centro de implementacion
2. Seleccionar Git local > continuar > Servicio de compilacion de App Service > Finalizar
3. Seleccionar Credenciales de implementacion > Credenciales de usuario > Ingresar nuevo nombre de usuario y password para Guardar credenciales.

## _Configuración de un Git remoto para implementar la aplicación en producción_
1. Obtener la URL de clonacion de Git desde la informacion general del web app en Azure Portal.
2. Ejecutar lo siguiente para configurar la YRL como GIT remoto llamado _production_
```
git remote add production <git-clone-url>
```
3. Para implementar la aplicación web en el espacio de producción, ejecutar el comando siguiente
```
git push production
```

## _Configuración de la implementación de Git para el espacio de ensayo_
1. En Azure Portal > Web App creado >  Implementacion > Centro de implementacion
2. Seleccionar Git local > Continuar > seleccionar Servicio de compilación de App Service > Continuar > Finalizar. 
3. Copiar la URL de clonacion de Git del espacio de ensayo. 
4. Para agregar la instancia remota para el espacio de ensayo, ejecutar el comando siguiente
```
git remote add staging <git-clone-uri>
```
5. Para modificar cambios en espacio de ensayo, ejecutar lo siguiente
```
git add .
git commit -m "New version of web app."
git push staging
```