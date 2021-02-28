# Creación de una máquina virtual Windows en Azure
Las VM Windows de Azure son un recurso de informática en la nube escalable y a petición. Similares a las máquinas virtuales hospedadas en Windows Hyper-V. Incluyen un procesador, memoria, almacenamiento y recursos de red. Se inician y se detienen del mismo modo que en Hyper-V y se administran desde Azure Portal o con la CLI de Azure. Se puede usar un cliente de Protocolo de escritorio remoto (RDP) para la conexión directa a la interfaz de usuario del escritorio de Windows.

## _Creación de una nueva máquina virtual Windows_
1. En Azure Portal > Create a resource > Search in market plate _Windows Server_
2. Seleccionar el plan _ [smalldisk] Windows Server 2019 Datacenter_ > Crear
3. Ingresar Resourge Group, nombre de VM, Region, Availabilty Option _No redundacy_, Size
4. Ingresar username, password
devniel93
D34rsdf#%$12
5. En reglas de puerto de entrada seleccionar RDP 3389
6. En Discos > Premium SSD 
7. Tipo de crifrado > _(Default) Encryption at-rest with a platform-managed key_
8. Crear nuevo disco de datos 
9. Crear nueva VNET > En Address Space > Address range > modificar 172.16.0.0/16 y en Subnets > Address range > modificar 172.16.1.0/24. Con esto Azure creara una red virtual, una interfaz de red y una direccion IP publica para la VM.
10. Revisar > Crear

## _Uso de RDP para conectarse a máquinas virtuales Windows en Azure_

### ¿Qué es el Protocolo de escritorio remoto?
RDP proporciona conectividad remota a la interfaz de usuario de equipos con Windows. Permite iniciar sesión en un equipo remoto Windows físico o virtual y controlar dicho equipo como si estuviese sentado en la consola.

Una conexión RDP requiere un cliente de RDP. Microsoft proporciona clientes de RDP para los siguientes SO:
- Windows (integrado)
- macOS
- iOS
- Android

También hay clientes de Linux de código abierto, como Remmina, que le permiten conectarse a un equipo Windows desde una distribución de Ubuntu.

### ¿Cómo se conecta a una máquina virtual en Azure con RDP?
En Azure Portal > Virtual Machine > seleccionar Connect > Descargar el RDP file para conectarse a la VM. Si se usa una dirección IP pública estática para la máquina virtual, puede guardar el archivo .rdp, pero si se usa una dirección IP dinámica, el archivo .rdp solo es válido mientras la máquina virtual está en ejecución. Si se detiene y reinicia la máquina virtual, se debe descargar otro archivo .rdp.

### Instalación de roles de trabajo
La primera vez que se conecte a una VM de servidor de Windows, se iniciará el Administrador del servidor. Esto permite asignar un rol de trabajo para tareas de datos o web comunes. Aquí es donde se agregaría el rol Servidor web al servidor. Esto instalará IIS y, como parte de la configuración, se desactivarían las solicitudes HTTP y se habilitaría el servidor FTP. O bien, se podría omitir IIS e instalar un servidor FTP de terceros. 

### Inicialización de discos de datos
Se habia agregado un disco duro virtual en Azure para esta VM Windows pero inicialmente no se lista como una unidad. Para esto se debe inicializar el disco desde la administracion de discos. Luego se debe darle un formato (NTFS por ejemplo) y asignarle una letra de unidad.