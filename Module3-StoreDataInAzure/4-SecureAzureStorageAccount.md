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

# Información sobre las claves de cuenta de almacenamiento
Las cuentas de Azure Storage pueden crear aplicaciones autorizadas en Active Directory para controlar el acceso a los datos de blobs y colas. Para otros modelos de almacenamiento, se pueden usar una clave compartida, la cual se inserta en la cabecera de una solicitud HTTP llamando _Authorization_ 

Por ejemplo, una solicitud GET
```
GET http://myaccount.blob.core.windows.net/?restype=service&comp=stats
```

Su encabezado incluiría la clave codificada:
```
x-ms-version: 2018-03-28  
Date: Wed, 23 Oct 2018 21:00:44 GMT  
Authorization: SharedKey myaccount:CY1OP3O3jGFpYFbTCBimLn0Xov0vt0khH/E5Gy0fXvg=
```

## _Claves de Storage Account_
Azure crea dos claves (principal y secundaria) para cada cuenta de almacenamiento que se crea, las cuales dan acceso a todo lo que hay en la cuenta. 

## _Protección de claves compartidas_
Storage account solo tiene dos claves que dan acceso completo a la cuenta y se debe usar solamente para aplicaciones internas de confianza.
Si las claves se comprometen, se debe cambiar los valores de clave en Azure Portal.

Para actualizar claves:
- Cambiar cada aplicación de confianza para usar la clave secundaria.
- Actualizar la clave principal en Azure Portal. Considerar como el nuevo valor de clave secundaria.

---

# Descripcion de Firma de acceso compartido (SAS)
Se recomienda no compartir claves de cuenta de almacenamiento con aplicaciones de terceros externas. En el caso de los clientes que no son de confianza, se debe usar una firma de acceso compartido (SAS), el cual es una cadena que contiene un token de seguridad que se puede asociar a un URI. SAS permite delegar el acceso a objetos de almacenamiento y especificar restricciones, como los permisos y el intervalo de tiempo de acceso.

## _Tipos de firmas de acceso compartido_
- SAS de nivel de servicio: Permite el acceso a recursos específicos de una cuenta de almacenamiento.
- SAS de nivel de cuenta: permite todo lo que permite SAS nivel de servicio mas otros recursos y capacidades como la creación de sistemas de archivos. 