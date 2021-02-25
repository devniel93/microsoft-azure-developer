# Protección de la cuenta de Azure Storage
## _Cifrado en Reposo_
Todos los datos escritos en Azure Storage se cifran automáticamente mediante Storage Service Encryption (SSE) con un cifrado AES de 256 bits y compatible con FIPS 140-2. Este proceso no supone ningún cargo adicional ni afecta al rendimiento.
- En el caso de las VMs, Azure cifra los discos duros virtuales mediante Azure Disk Encryption. Se usa imágenes de BitLocker para Windows y dm-crypt para Linux.
- Azure Key Vault almacena las claves automáticamente para ayudar a controlar y administrar los secretos.

## _Cifrado en tránsito_
Se mantiene los datos protegidos al habilitar segurindad de nivel de transporte entre Azure y el cliente. Para esto se debe usar HTTPS para la protección de la comunicación. También, se aplica transferencia seguria a través de SMB 3.0 para los recursos compartidos de archivos.

## Compatibilidad con CORS
Azure storage permite el acceso entre dominios mediante CORS, el cual se usa como encabezados de HTTP para que una app web en cierto dominio pueda acceder a los recursos de un servidor de otro dominio. 

## _Control de acceso basado en rol_
Para acceder a los datos Azure brinda varias opciones, una de las cuales es el contro de acceso basado en rol (RBAC). Azure Storage usa Active Directory para autorizar operaciones de administración de recursos como la configuración. Se puede asignar roles de RBAC a una suscripción, grupo de recursos, cuenta de almacenamiento, contendor individual o cola.

## _Auditoría de acceso_
Se puede auditar a través de Storage Analytics, el cual registra cada operación en tiempo real.

---