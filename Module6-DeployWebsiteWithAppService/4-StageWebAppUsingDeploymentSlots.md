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

---

## _Implementación de una aplicación web mediante el intercambio de ranuras de implementación_
Cuando intercambia dos ranuras, la configuración de la aplicación viaja a la ranura nueva junto con la aplicación. Puede invalidar este comportamiento para la configuración de la aplicación individual y las cadenas de configuración si las configura como `configuración de ranura`.

### Configuración de los valores de ranura
1. En Azure Portal > Ranura de implementacion > Configuracion
2. Editar los valores de configuracion de aplicacion o cadenas de conexion.

### Intercambio de ranuras en Azure Portal
1. En Azure Portal > Ranura de implementacion de la web app > Ranuras de implementacion
2. Seleccionar Intercambiar
3. En el cuadro de diálogo Intercambiar, puede seleccionar las ranuras de origen y destino y ver un resumen de la configuración que se aplicará a las ranuras intercambiadas:

### Descripción de la vista previa de intercambio de ranuras
Al intercambiar las ranuras, la configuración de la ranura de destino (que normalmente es el espacio de producción) se aplica a la versión de la aplicación en la ranura de origen antes de que se intercambien los nombres de host.

Para ayudar a detectar problemas antes de que la aplicación se lance a producción, Azure App Service ofrece una característica de intercambio con vista previa que se realiza en 2 fases:
- Fase 1: la configuración de ranura de la ranura de destino se aplica a la aplicación web en la ranura de origen. Luego, Azure prepara el espacio de ensayo. En este momento, la operación de intercambio se pausa para que se pueda probar la aplicación en la ranura de origen y asegurarse de que funciona con la configuración de la ranura de destino. Si no detecta ningún problema, comience la fase siguiente.
- Fase 2: se intercambian los nombres de host de ambos sitios. La versión de la aplicación que ahora está en la ranura de origen recibe su configuración de ranura.

### Intercambio automático
Lleva las ventajas de no tener tiempo de inactividad y la reversión sencilla de la implementación basada en intercambio a las canalizaciones de implementación automatizada.
El intercambio automático no está disponible en App Service en Linux.

### Configuración del intercambio automático
1. En Azure Portal > Selecionar Configuracion general de la ranura > Ranura de implementacion > Establecer Intercambio auomtatico habilitado
2. Seleccionar la ranura de destino
3. Guardar