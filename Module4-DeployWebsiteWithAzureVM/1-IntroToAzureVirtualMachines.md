# Crear una lista de comprobación para crear una máquina virtual de Azure

- Empezar por la red
- Asignación de un nombre a la máquina virtual
- Decidir la ubicación de la máquina virtual
- Determinación del tamaño de la máquina virtual
- Descripción del modelo de precios
- Almacenamiento de la máquina virtual
- Selección de un sistema operativo

## _Empezar por la red_
Las virtual network se usan en Azure para conectividad privada entre las VMs y otros servicios de azure. Las VMs tienen acceso mutuo con otros servicios dentro de la misma virtual network y los que estan fuera de esta vnet no pueden conectarse, pero se puede configurar la vnet para permitir este acceso.

Cuando se configura una virtual network, se puede especificar los espacios de direcciones disponibles, las subnets y la seguridad. Si la vnet se va a conectar a otras vnets, es preciso seleccionar intervalos de direcciones que no se superpongan.

## _Segregación de la red_
Después de decidir los espacios de direcciones de la vnet, se puede crear una o varias subnets para dividir la red en secciones más fáciles de administrar. Por ejemplo, se podría asignar 10.1.0.0 a las máquinas virtuales, 10.2.0.0 a los servicios back-end y 10.3.0.0 a las máquinas virtuales con SQL Server.
* Azure reserva las cuatro primeras direcciones y la última de cada subred para uso interno.

## _Protección de la red_
Por default, los servicios de cada una de las subnets pueden comunicarse entre si, pero se pueden configurar network security groups (NSG) para controlar el trafico entrante y saliente de las subnets y de las VMs. Estos NSG actuan como firewalls en donde se aplican reglas en el nivel de interfaz de la vnet y la subnet, lo que permite controlar las solicitudes que entran o salen de la VM.

## _Planeamiento de la implementación de cada máquina virtual_
Para implementar una VM, se debe pensar en las siguientes preguntas:
- ¿Con qué se comunica el servidor?
- ¿Qué puertos están abiertos?
- ¿Qué sistema operativo se usa?
- ¿Cuánto espacio en disco está en uso?
- ¿Qué tipo de datos usa? ¿Hay alguna restricción (legal o no) por no tenerlo en una ubicación local?
- ¿Qué tipo de CPU, memoria y carga de E/S de disco tiene el servidor? ¿Hay picos de tráfico que se deban tener en cuenta?

## _Asignación de un nombre a la máquina virtual_
El nombre de la VM se usa como nombre del equipo, que está configurado como parte del sistema operativo. Se permite hasta 15 caracteres en una VM Windows y hasta 64 caracteres en una VM Linux. El nombre tambien permite definir un recurso de Azure administrable y no es facil de cambiar luego.

## _¿Qué es un recurso de Azure?_
Es un elemento fácil de administrar en Azure. Las VM tiene varios elementos o recursos que son necesarios:
- La propia máquina virtual
- Una cuenta de almacenamiento para los discos
- Una red virtual (compartida con otras máquinas virtuales y servicios)
- Una interfaz de red para comunicarse en la red virtual
- Grupos de seguridad para proteger el tráfico de red
- Una dirección pública de Internet (opcional)

## _Decidir la ubicación de la máquina virtual_
Al crear e implementar una máquina virtual, se debe seleccionar la región en la que quiere que se asignen los recursos (CPU, almacenamiento, etc). Esto permite colocar las máquinas virtuales lo más cerca posible de los usuarios para mejorar el rendimiento y cumplir con todos los requisitos legales, de cumplimiento o fiscales.

Se deben considerar 2 cosas con respecto a la seleccion de la ubicacion. Primero, la ubicacion puede limitar algunas opciones y segundo, hay diferencias de precios entre las regiones.

## _Determinación del tamaño de la máquina virtual_
Una vez que ha establecido el nombre y la ubicación, debe decidir el tamaño de la máquina virtual. La mejor manera de determinar el tamaño de máquina virtual adecuado es tener en cuenta el tipo de carga de trabajo que la máquina virtual debe ejecutar. Se cuenta con las siguientes opciones:

- De uso general: 
Diseñados para proporcionar una relación equilibrada entre CPU y memoria. Ideal para desarrollo y testing, bases de datos pequeñas o medianas, y servidores web de tráfico bajo o medio.

- Optimizada para proceso:
Diseñadas para proporcionar una relación alta entre CPU y memoria. Adecuado para servidores web de tráfico medio, aplicaciones de red, procesos por lotes y servidores de aplicaciones.

- Optimizada para memoria:
Diseñadas para proporcionar una relación alta entre memoria y CPU. Adecuado para servidores de BD relacionales, memorias cache de media o gran capacidad y analisis en memoria.

- Optimizada para almacenamiento:
Diseñadas para tener un alto rendimiento de disco y E/S. Ideal para VMs que ejecutan base de datos.

- GPU:
son máquinas virtuales especializadas específicas para la representación de gráficos pesados y la edición de vídeo. Ideal para entrenamiento de modelos y aprendizaje profundo.

- Informática de alto rendimiento:
VMs de CPU más rápidas y potentes con interfaces de red de alto rendimiento opcionales.

## _¿Qué ocurre si mis necesidades de tamaño cambian?_
Azure permite actualizar o degradar la VM, siempre y cuando se permita la configuración del hardware actual en el nuevo tamaño. Se puede cambiar el tamaño de VM mientras esta se está ejecutando, siempre que el nuevo tamaño esté disponible en el clúster de hardware actual en el que se está ejecutando la VM. Si detiene y desasigna la VM, entonces puede seleccionar cualquier tamaño disponible en su región, ya que esto quita la VM del clúster en el que se estaba ejecutando. 
* Tener cuidado al cambiar el tamaño de las máquinas virtuales de producción, ya que se reiniciarán automáticamente, lo que puede provocar una interrupción temporal y cambiar algunos valores de configuración, como la dirección IP.

## _Descripción del modelo de precios_
Hay dos costos independientes por los que se cobra en la suscripción de cada VM: proceso y almacenamiento.

- Costos de proceso:
Tienen un precio por horas pero se facturan por minutos. El precio varía en función del tamaño de máquina virtual y del sistema operativo que seleccione. El costo incluye la licencia de Windows pero las instancias de Linux son mas baratas porque no hay gastos de licencias.

- Costos de almacenamiento:
Se cobra por separado por el almacenamiento que usa la VM. Incluso aunque la VM esté detenida o desasignada y no se le facture por la VM en ejecución, se le cobrará por el almacenamiento que empleen los discos.

Hay 2 opciones de pago:
- Pago por uso: 
Paga por la capacidad de proceso por segundo, sin ningún tipo de compromiso a largo plazo ni pago por adelantado.

- Instancias reservadas de máquina virtual:
Es una compra por adelantado de una máquina virtual para uno o tres años en una región determinada. El compromiso se realiza por adelantado y, a cambio, se obtiene una rebaja en el precio de hasta un 72 %.

## _Almacenamiento de la máquina virtual_
Todas las VMs tienen al menos dos discos duros virtuales (VHD). El primero almacena el SO y el segundo se usa como almacenamiento temporal. Por default, vienen  discos por CPU en la VM. Separar los datos en VHD permite administrar seguridad, confiabilidad y rendimiento. Los datos de cada VHD se almacena en Azure Storage como blobs en paginas. Paga solo por el almacenamiento que se consume.

## _¿Qué es Azure Storage?_
Es una solución de almacenamiento de datos basada en la nube de Microsoft. Las VMs siempre tienen una o varias cuentas de almacenamiento que contienen todos los discos virtuales conectados. Los VHD pueden estar respaldados por cuentas de almacenamiento de nivel Estándar o Premium. Azure Premium Storage aprovecha las unidades de estado sólido (SSD) para un altor renidmiento y baja latencia en las VMs de Produccion, mientras que para desarrollo p testing se puede usar el nivel Estandar.

Al crear discos, hay dos opciones para administrar la relación entre la cuenta de almacenamiento y cada disco duro virtual:
- Discos no administrados:
El usuario es responsable de las cuentas de almacenamiento que se utilizan para contener los discos duros virtuales correspondientes a los discos de la VM.

- Discos administrados:
Es el modelo de almacenamiento de disco recomendado más reciente. Solucionan de forma elegante esa complejidad al situar en Azure la responsabilidad de administrar las cuentas de almacenamiento. Permite el escalado horizontal.

## _Selección de un sistema operativo_
Azure proporciona diversas imágenes de sistema operativo que se pueden instalar en la máquina virtual, incluidas varias versiones de Windows y tipos de Linux. Se puede buscar en Azure Marketplace imágenes de instalación más sofisticadas que incluyan el sistema operativo y las herramientas de software más conocidas instaladas para escenarios específicos.

--- 

# Creación de una máquina virtual desde Azure Portal

## _Azure Portal_
Para este ejemplo se usan los siguientes pasos:
1. Inicia sesion en portal.azure.com
2. Seleccionar _Create new resource_ > Compute > Virtual Machine
3. Seleccionar suscripcion, resource group, ingrsar nombre, region.
4. Seleccionar como imagen Servidor de Ubuntu 18.04 LTS
5. En Size Seleccionar Standar DS2 V3
6. Tipo de autenticacion: Password.
7. Ingresar username y password.
admindevniel93
AdminDevniel93
8. Seleccionar _Review and create_
9. Por ultimo, seleccionar _Create_

## _Descripción de las opciones disponibles para crear y administrar una máquina virtual de Azure_

Existen otras formas de crear una maquina virtual en Azure:
- Azure Resource Manager
- Azure PowerShell
- Azure CLI
- API REST de Azure
- SDK de cliente de Azure
- Extensiones de máquina virtual de Azure
- Servicios de Azure Automation

### Azure Resource Manager
Aumenta la eficacia de la creacion de una VM al organizar en grupos los recursos que con llevan crear una VM como el almacenamiento y la interfaz de red. Resource Manager permite crear _templates_ que se pueden usar para implementar configuraciones especificas.

Los _templates_ de Resource Manager (ARM) son archivos JSON donde se definen los recursos que se necesitan para implementar una solucion. Se puede crear una plantilla desde la seccion del VM > _Automation_ > _Export template_

### Azure PowerShell
Crear scripts de administracion es una manera eficaz de optimizar el trabajo. Se pueden crear scripts para automatizar tareas repetitivas. Azure PowerShell permite realizar estos scrpts mediante los comandos cmdlets.

Por ejemplo, para crear una VM con Azure PowerShell:
```
New-AzVm `
    -ResourceGroupName "TestResourceGroup" `
    -Name "test-wp1-eus-vm" `
    -Location "East US" `
    -VirtualNetworkName "test-wp1-eus-network" `
    -SubnetName "default" `
    -SecurityGroupName "test-wp1-eus-nsg" `
    -PublicIpAddressName "test-wp1-eus-pubip" `
    -OpenPorts 80,3389
```

### CLI de Azure
Es otra opcion de Azure para crear scripts por lineas de comandos que permite administrar recursos de Azure como VMs y discos. Disponible en MAC, Windows, Linux o en el explorador con Cloud Shell. A diferencia de Azure PowerShell, Azure CLI no necesita PowerShell. Normalmente se usa en maquinas no Windows o en las que el desarrollador no esta familiarizado con PowerShell.

Por ejemplo, para crear una VM con Azure CLI:
```
az vm create \
    --resource-group TestResourceGroup \
    --name test-wp1-eus-vm \
    --image win2016datacenter \
    --admin-username jonc \
    --admin-password aReallyGoodPasswordHere
```

### Mediante programación (API)

#### API REST de Azure
Ofrece a los desarrolladores operaciones hacia recursos, en donde las operacioenes se exponen como URIs con los metodos HTTP.
Con esta API, dispone de operaciones para:
- Crear y administrar conjuntos de disponibilidad
- Agregar y administrar extensiones de máquinas virtuales
- Crear y administrar discos administrados, instantáneas e imágenes
- Acceder a las imágenes de plataforma disponibles en Azure
- Recuperar la información de uso de los recursos
- Crear y administrar máquinas virtuales
- Crear y administrar conjuntos de escalado de máquinas virtuales

#### SDK de cliente de Azure
El SDK encapsula la API REST de Azure y esta disponible en varios lenguajes como .NET, C#, Java, NodeJS y otros.

Por ejemplo, para crear una VM por medio del paquete NuGet `Microsoft.Azure.Management.Fluent`:
```
var azure = Azure
    .Configure()
    .WithLogLevel(HttpLoggingDelegatingHandler.Level.Basic)
    .Authenticate(credentials)
    .WithDefaultSubscription();
// ...
var vmName = "test-wp1-eus-vm";

azure.VirtualMachines.Define(vmName)
    .WithRegion(Region.USEast)
    .WithExistingResourceGroup("TestResourceGroup")
    .WithExistingPrimaryNetworkInterface(networkInterface)
    .WithLatestWindowsImage("MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter")
    .WithAdminUsername("jonc")
    .WithAdminPassword("aReallyGoodPasswordHere")
    .WithComputerName(vmName)
    .WithSize(VirtualMachineSizeTypes.StandardDS1)
    .Create();
```

El mismo ejemplo pero con el SDK de Java:
```
String vmName = "test-wp1-eus-vm";
// ...
VirtualMachine virtualMachine = azure.virtualMachines()
    .define(vmName)
    .withRegion(Region.US_EAST)
    .withExistingResourceGroup("TestResourceGroup")
    .withExistingPrimaryNetworkInterface(networkInterface)
    .withLatestWindowsImage("MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter")
    .withAdminUsername("jonc")
    .withAdminPassword("aReallyGoodPasswordHere")
    .withComputerName(vmName)
    .withSize("Standard_DS1")
    .create();
```

#### Extensiones de máquina virtual de Azure
Sirve para configurar e instalar software adicional en la VM despues de la implementacion incial. Las extensiones de VM se pueden ejecutar por Azure CLI, PowerShell, templates de ARM y Azure Portal.

#### Servicios de Azure Automation
Permite integrar servicios que, a su vez, permiten automatizar tareas de administración frecuentes, lentas y propensas a errores con facilidad. Entre estos servicios se incluyen los siguientes:
- Automatización de procesos:
Se puede automatizar el proceso que pueda dar respuesta a eventos que se pueden productir en una VM como errores especificos.

- Administración de configuración:
Se puede realizar seguimiento de actualizaciones de software disponibles para el SO de una VM y actuar segun lo necesario. Por medio de _Microsoft Endpoint Configuration Manager_ se puede administrar el equipo, los servidores y dispositivos moviles. Tambien, se puede amplicar esta compatibilidad con _Azure Configuration Manager_

- Administración de actualizaciones:
Se usa para administrar actualizaciones y revisiones de las VMs. uede evaluar rápidamente el estado de las actualizaciones disponibles, programar la instalación y revisar los resultados de la implementación para comprobar si las actualizaciones se aplicaron correctamente. Se puede habilitar en una VM desde la cuenta de _Azure Automation_.