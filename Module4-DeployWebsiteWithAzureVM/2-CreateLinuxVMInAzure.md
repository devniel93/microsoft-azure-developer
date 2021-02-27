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