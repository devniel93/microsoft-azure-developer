# Creación de una máquina virtual Linux en Azure
Las Azure Virtual Machines o VMs son recursos de nube escalables que incluyen memoria, procesador, almacenamiento y recursos de red, pueden administrarse por Azure Portal o Azure CLI y se puede conectar por SSG remotamente.

## _Recursos que se usan en una máquina virtual Linux_
Al crearse una VM, se crean recursos necesarios para hospedarla:
- Una máquina virtual que proporcione recursos de CPU y memoria
- Una cuenta de Azure Storage que hospede los discos duros virtuales
- Discos virtuales que hospeden el sistema operativo, las aplicaciones y los datos
- Una red virtual para conectar la máquina virtual a otros servicios de Azure o al hardware local
- Una interfaz de red para comunicarse con la red virtual
- Una dirección IP pública opcional para acceder a la máquina virtual
- Un grupo de recursos que contenga la máquina virtual 

## _Elección de la imagen de máquina virtual_
Una imagen es una plantilla que se usa para crear una máquina virtual e incluyen un sistema operativo y, a menudo, otro software, como herramientas de desarrollo o entornos de hospedaje web.

## _Ajuste del tamaño de la máquina virtual_
Azure ofrece distintos tamaños con diferentes precios. El tamaño considera factores como la capacidad de procesamiento, la memoria y la capacidad de almacenamiento máxima de la máquina virtual.

Las siguientes son algunas instrucciones para elegir el tamaño en base al escenario:
| Que hace? | Tamaños recomendados |
| --- | ----------- |
| Web o informática de uso general: para desarrollo y pruebas, bases de datos pequeñas o medianas, y servidores web de tráfico bajo o medio. | B, Dsv3, Dv3, DSv2, Dv2 |
| Tareas de cálculo intensivo: para servidores web de tráfico medio, aplicaciones de red, procesos por lotes y servidores de aplicaciones.	 | Fsv2, Fs, F |
| Gran uso de memoria: para servidores de bases de datos relacionales, memorias caché de capacidad media o grande y análisis en memoria.	 | Esv3, Ev3, M, GS, G, DSv2, Dv2 |
| Representación de gráficos intensiva o edición de vídeo, así como para el aprendizaje y la inferencia de modelos (ND) con aprendizaje profundo. | NV, NC, NCv2, NCv3, ND |
| Informática de alto rendimiento (HPC): sus cargas de trabajo necesitan las máquinas virtuales de CPU más rápidas y eficaces con interfaces de red de alto rendimiento opcionales. | H |

## _Elección de las opciones de almacenamiento_
Se puede escoger entre HDD o SSD. El SSD cuesta mas pero ofrece mejor rendimiento. Se debe elegir discos SSD Estándar si tiene cargas de trabajo normales, pero se desea mejorar el rendimiento. Elegir discos SSD Premium si tiene cargas de trabajo que realizan un uso intensivo de la E/S o sistemas críticos que necesitan procesar datos muy rápidamente.

### Asignación de almacenamiento a discos
Azure usa los discos duros virtuales (VHD) para representar discos físicos para la máquina virtual. Estos VHD replican el formato logica de una unidad de disco pero se almacenan en blobs en paginas en un Azure Storage. En cada disco se puede elegir usar SSD o HDD. 

Por default, se crean 2 VHD para la VM Linux:
- El disco del sistema operativo: esta es la unidad principal y tiene una capacidad máxima de 2048 GB. De forma predeterminada se etiqueta como `/dev/sda`.

- Disco temporal: proporciona almacenamiento temporal al SO o aplicaciones. El disco temporal no es persistente, solo se deben escreibir datos que no sean criticos para el sistema.

### ¿Qué sucede con los datos?
Los datos se pueden almacenar en la unidad principal junto con el sistema operativo, pero es mejor crear discos de datos dedicados. Se puede crear y conectar discos adicionales a la VM. Cada disco puede tener un maixmo de 32767 GiB y la cantidad maxima de almacenamiento la determina el tamaño de la VM.

## _Diferencias entre discos administrados y no administrados_
Con los discos no administrados, el usuario es el responsable de las cuentas de almacenamiento que contienen los discos duros virtuales correspondientes a sus discos de VM.

Los discos administrados son el modelo de almacenamiento en disco más reciente y el recomendado. Solucionan de larma de administrar las cuentas de almacenamiento y facilita el escalado horizontal.

## _Comunicación de red_
Las VMs se comunican con recursos externos mediante una VNet, el cual representa una red privada de una sola region y se pueden dividir en subnets para aislar recursos, conectarlas a otras redes y aplicar reglas de trafico entrante y saliente.

### Planificación de una red
Es mejor planear la red virtual antes de la creacion de la VM. 

--- 

# Decisión de un método de autenticación de SSH
Para acceder remotamente a las VM se puede usar SSH.

## _¿Qué es SSH?_
Secure Shell (SSH) es un protocolo de conexión cifrada que permite inicios de sesión seguros a través de conexiones no seguras. SSH permite conectarse a un shell de terminal desde una ubicación remota mediante una conexión de red.
Para autenticar una conexion por SSH se puede usar 2 metodos:
- Username y password: No recomendado por vulnerabilidad ante ataque fuerza bruta.
- Par de claves SSH: Seguro y preferible metodo de autenticacion.

Un Par de claces consiste en una clave publica y otra clave privada.
- La clave pública se coloca en la máquina virtual Linux o en cualquier otro servicio que se quiera usar con una criptografía de clave pública. Se puede compartir con cualquiera.
- La clave privada es la que se presenta para verificar la identidad en la máquina virtual Linux al crear una conexión SSH. Considere que es información confidencial y protéjala como si fuera una contraseña o cualquier otro dato privado.

## _Creación del par de claves SSH_
Se puede usar el comando ssh-keygen integrado para generar los archivos de clave pública y privada SSH.

1. Ejecutar el comando para gneerar el par de claves con protocolo SSH 2.
```
ssh-keygen -m PEM -t rsa -b 4096
```

2. Presionar enter para aceptar la ubicacion y se creara dos archivos `id_rsa` e `id_rsa.pub`, en el directorio `~/.ssh`

3. Escribir y confirmar una frase de contraseña de clave privada
devniel93

### Frase de contraseña de clave privada
Se usa para acceder al archivo de claves SSH privado y no es la contraseña de la cuenta de usuario. Cuando se agrega una frase de contraseña a la clave SSH, cifra la clave privada mediante AES de 128 bits para que la clave privada no se pueda usar sin la frase de contraseña para descifrarla.

Es recomendable agregrar una frase de contraseña ya que si un atacante robara la clave privada y esta no tuviera una frase de contraseña, podría usarla para iniciar sesión en los servidores que tuvieran la clave pública correspondiente. 

### Usar el par de claves SSH con una máquina virtual Linux de Azure
Para ver el contenido de la clave publica
```
cat ~/.ssh/id_rsa.pub
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC80SSgshKsWr7g4lB+OFeG101CYh5JB9kiUL6ZnbB6YMSP0LGWRdg/ijWO+3KOUi3WM1D+ofy7YzcxLCXC+Gs+Dsu95hAj6sXZh5WmTExaEt1+DemGwlNaBXMIZ6tpVsFQm9MrYaWL+/B4VwFcerWys3brWenNcpTtPgJRZtI+7D0Cfcxd7JxcxP4kyCZ4ImFad0I2WnsMMR029XBRIHVbw4Rvi3SbSjTMXW+PtNlzib1BMrKYF4oL7PL2eRxXruPILEy/qHWa21b4lQC+8M/vKfL/qYBPQ5h6q0AaUaneQ1AVVZoY72kkVfFbOejiL8V+xyik96J0bWudY9z6i5QF4MAAbPtzcOaFS6Lx8U7IwRbpPjoHH3NjyZhjBzFPeRXOHlz8vtV8V4PNZ7nZTPBtTwxYWJsmCKJL50pxjp5bmf22wPSs4dpKyR9XTmgEbYjdYGpFCzvZrUE49Y8JpT57gMiaDqaxQXWsQGOK8zQL+R+dhsx1v8z4s/DvLpuuUkzQjcFv6muGZv04L6AkxLGsLZGod+lSxjGKEjfWmQDpzVQLflrJOa6ztcbCqCWUQgjl/n1dXaq506CdhP+rsQzOyWB6kS4CwsCl+iAddok2P/t+ktWmsOLGVhknl86KgjBURsw4cnwjkq8MkU14wICyWJgVqB6Hy0kyJzJTn0Ucpw== danielolanoburga@cc-732e18ea-6d498bb946-lhf75

### Adición de la clave SSH a una máquina virtual Linux existente
Se puede instalar la clave publica en una VM con el siguiente comando, donde _myserver_ es la VM y _azureuser_ es el usuario.
```
ssh-copy-id -i ~/.ssh/id_rsa.pub azureuser@myserver
```

---

# Opciones SSH y direcciones IP de las máquinas virtuales de Azure
A menos que haya configurado una VPN de sitio a sitio en Azure, las máquinas virtuales de Azure no serán accesibles desde la red local.

## _Direcciones IP de las máquinas virtuales de Azure_
Las VM se comunican mediante red virtual y pueden tener una IP puiblica, el cual permite interacctuar a traves de internet. Alternativamente, se puede configurar una VPN para conectar la red local a Azure sin necesidad de exponer una IP publica. 

Las IP publicas se asignan dinamicamente, es decir que pueden cambiar con el tiempo o cuando se reinicia la VM. Si se requiere una IP publica estatica se paga msa.

## _Conexión a la máquina virtual con SSH_
Para conectarse a la máquina virtual a través de SSH, necesita lo siguiente:

- la dirección IP pública de la máquina virtual
- el nombre de usuario de la cuenta local en la máquina virtual
- una clave pública configurada en esa cuenta
- acceso a la clave privada correspondiente
- el puerto 22 abierto en la máquina virtual

1. Para conectarse, se puede obtener el comando desde Azure Portal > Connect > SSH
```
ssh azureuser@13.68.150.164
```
2. Para obtener una lista de todos los dispositivos de bloque, donde se ve las unidades de disco
Ejecutar `lsblk`

3. Para inicialiar o montar una unidad de datos en el sistema de archivos
Ejecutar lo siguinete para especificar el disco que crear una nueva particion principal:
```
(echo n; echo p; echo 1; echo ; echo ; echo w) | sudo fdisk /dev/sdc
```

4. Escribir un sistema de archivo en la particion:
```
sudo mkfs -t ext4 /dev/sdc1
```

5. Montar la unidad en el sistema de archivos y creacion de una carpeta como punto de montaje
```
sudo mkdir /data && sudo mount /dev/sdc1 /data
```

## _Instalación de un software: Servidor web Apache_
1. Actualizar el indice de paquetes local
```
sudo apt-get update
```

2. Instalar Apache
```
sudo apt-get install apache2 -y
```

3. Iniciar de foma automatica
```
sudo systemctl status apache2 --no-pager
```

---

# Configuración de red y seguridad
Se puede modificar la configuración, administrar redes, abrir o bloquear el tráfico y mucho más mediante Azure Portal, la CLI de Azure o las herramientas de Azure PowerShell.

## _Apertura de puertos en máquinas virtuales de Azure_
De forma predeterminada, las nuevas VMs están bloqueadas. Las aplicaciones pueden realizar solicitudes salientes pero trafico entrantes solo se prmite desde la red virtual y desde Azure Load Balancer. Hay 2 pasos para adminitir distintos protocolos de red:
- Crear un grupo de seguridad de red.
- Crear una regla de entrada que permita el tráfico con los puertos que se necesitan.

### ¿Qué es un grupo de seguridad de red?
Son la principal herramienta para aplicar y controlar las reglas de tráfico de red en el nivel de red. Proporciona un firewall de software gracias al filtrado del tráfico entrante y saliente de la red virtual. Se pueden asociar a una interfaz de red (para reglas por host), una subred de la red virtual (para aplicar a varios recursos) o a ambos niveles.

#### Reglas del grupo de seguridad
Los NSG usan reglas para permitir o denegar el movimiento del tráfico a través de la red. Cada regla identifica las direcciones de origen y destino (o rangos), el protocolo, el puerto (o rango), la dirección (entrante o saliente), una prioridad numérica y si desea permitir o denegar el tráfico que coincide con la regla.

#### Uso de las reglas de red por parte de Azure
Para el tráfico entrante, Azure procesa el grupo de seguridad asociado a la subred y, después, el grupo de seguridad que se aplica a la interfaz de red. El tráfico saliente se controla en orden inverso (la interfaz de red en primer lugar, seguida de la subred).

Las reglas se evalúan en orden de prioridad, comenzando por la regla de prioridad más baja. Las reglas de denegación siempre detienen la evaluación. 

La última regla es siempre una regla de Denegar todo. Se trata de una regla predeterminada que se agrega a todos los grupos de seguridad para el tráfico entrante y saliente con una prioridad de 65500. Para que el tráfico pase por el grupo de seguridad, debe tener una regla de permiso o la regla final predeterminada lo bloqueará.