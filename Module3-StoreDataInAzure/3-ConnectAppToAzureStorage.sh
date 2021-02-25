Conexion de una aplicacion a Azure Storage

Microsoft Azure Storage es un servicio administrado que proporciona 
almacenamiento duradero, seguro y escalable en la nube. 

- Duradero:
La redundancia garantiza que los datos están seguros en caso de errores de 
hardware transitorios. También puede replicar datos entre centros de datos 
o regiones geográficas. Los datos replicados de esta manera permanecen con 
una alta disponibilidad en caso de una interrupción inesperada.
- Seguro:	
El servicio cifra todos los datos escritos en Azure Storage. Proporciona un 
control pormenorizado sobre quién tiene acceso a los datos.
- Escalable:	
Azure Storage está diseñado para poderse escalar de forma masiva para 
satisfacer las necesidades de rendimiento y almacenamiento de datos de las 
aplicaciones de hoy en día.
- Administrado:	
Microsoft Azure se encarga del mantenimiento y de cualquier problema crítico 
que pueda surgir.

Una sola suscripción de Azure puede hospedar hasta 200 cuentas de 
almacenamiento, cada una de las cuales puede contener 500 TB de datos.

Servicios de datos de Azure
- Blobs: Un almacén de objetos que se puede escalar de forma masiva para 
datos de texto y binarios. Puede incluir compatibilidad con Azure Data Lake 
Storage Gen2.
- Archivos: recursos compartidos de archivos administrados para 
implementaciones locales y en la nube.
- Colas: Un almacén de mensajería para mensajería confiable entre 
componentes de aplicación.
- Table Storage: un almacén NoSQL para el almacenamiento sin esquema de 
datos estructurados. Table Storage no se trata en este módulo.

Blob Storage
Es una solución de almacenamiento de objetos optimizada para el 
almacenamiento de cantidades masivas de datos no estructurados, como texto 
o datos binarios

Blob Storage resulta conveniente para:
- Suministrar imágenes o documentos directamente a un explorador, incluidos 
sitios web estáticos completos.
- Almacenamiento de archivos para el acceso distribuido.
- Streaming de audio y vídeo.
- Almacenamiento de datos para copia de seguridad y restauración, 
recuperación ante desastres y archivado.
- Almacenamiento de datos para el análisis por un servicio local u hospedado 
por Azure.

Azure Storage admite tres tipos de blobs:
- Block blobs: 
Los blobs en bloques se usan para contener archivos de texto o binarios de 
hasta ~5 TB (50 000 bloques de 100 MB) de tamaño. El caso de uso principal 
de los blobs en bloques es el almacenamiento de archivos que se leen de 
principio a fin, como los archivos multimedia o los archivos de imagen de 
sitios web.

- Page blobs:
Se usan para almacenar archivos de acceso aleatorio de hasta 8 TB de tamaño.
Se usan principalmente como almacenamiento de seguridad de los discos duros 
virtuales empleados para proporcionar discos duraderos para Azure VMs
Proporcionan acceso aleatorio de lectura y escritura a páginas de 512 bytes

- Append blobs:
Constan de bloques, como los blobs en bloques, pero están optimizados para 
operaciones de anexión. Se usan para registrar información de uno o más 
orígenes en el mismo blob. Un blob en anexos solo puede tener hasta 195 GB.

Azure Files
Permite configurar recursos compartidos de archivos de red de alta 
disponibilidad mediante el protocolo estándar Bloque de mensajes del 
servidor (SMB), lo que permite que varias máquinas virtuales pueden 
compartir los mismos archivos con acceso de lectura y escritura.

Los recursos compartidos de archivos se pueden usar en escenarios:
- Almacenamiento de archivos de configuración compartidos de máquinas 
virtuales, herramientas o utilidades para que todos usen la misma versión.
- Archivos de registro, como diagnóstico, métricas y volcados de memoria.
- Datos compartidos entre aplicaciones locales y máquinas virtuales de 
Azure para permitir la migración de aplicaciones a la nube durante un 
período de tiempo.

Azure Queues
Se usa para almacenar y recuperar mensajes. Los mensajes de la cola pueden 
tener un tamaño de hasta 64 KB y una cola contener millones de mensajes. Se 
usan para almacenar listas de mensajes y procesarlas de forma asincrónica.

Azure storage accounts
Para acceder a cualquiera de estos servicios desde una aplicación, se tiene
que crear un storage account. 
Se puede crear una cuenta de Azure Storage mediante Azure Portal, Azure 
PowerShell o la CLI de Azure. Ofrece tres opciones de cuenta distintas, 
con diferentes precios y características:
- General-purpose v2 (GPv2): 
Son cuentas de almacenamiento que admiten las características más recientes 
de blobs, archivos, colas y tablas.

- General-purpose v1 (GPv1): 
Las cuentas de uso general v1 (GPv1) proporcionan acceso a todos los 
servicios de Azure Storage, pero puede que no incluyan las características 
más recientes o que no tengan los precios más bajos por gigabyte.

- Blob storage accounts:
Es un tipo de cuenta heredada, admiten las mismas características de blob 
en bloques que GPv2, pero tienen la limitación de que solo admiten blobs 
en bloques y en anexos.

###########

Conectar una aplicacion .NET core con Azure Storage Account

1. Crear la aplicacion
dotnet new console --name PhotoSharingApp

2. Correr la aplicacion 
dotnet run

3. Creacion de un storage account
az storage account create \
  --resource-group [sandbox resource group name] \
  --location eastus \
  --sku Standard_LRS \
  --name <name>

4. Adicion del paquete NuGet de Azure Storage
dotnet add package Azure.Storage.Blobs

5. Configurar Azure Storage en la aplicacion

Crear archivo de configuración
touch appsettings.json

Editar el archivo de configuración
{
    "ConnectionStrings": {
        "StorageAccount": "<value>"
    }
}

Obtener cadena de conexion para editarlo en el archivo de configuración
az storage account show-connection-string \
  --resource-group [sandbox resource group name] \
  --query connectionString \
  --name <name>

Editar el archivo PhotoSharingApp.csproj
<ItemGroup>
    <None Update="appsettings.json">
        <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
    </None>
</ItemGroup>

6. Compatibilidad para leer un archivo de configuración JSON

Agregar paquete NuGet
dotnet add package Microsoft.Extensions.Configuration.Json

Editar el archivo Program.cs:

using System;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace PhotoSharingApp
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");

            var configuration = builder.Build();
        }
    }
}

7. Conexión de la aplicación a la cuenta de Azure Storage

Editar el Program.cs:

using Azure.Storage.Blobs;

var connectionString = configuration.GetConnectionString("StorageAccount");
string containerName = "photos";

BlobContainerClient container = new BlobContainerClient(connectionString, containerName);

container.CreateIfNotExists();

8. Ejecutar la aplicacion
dotnet run

9. Para comprobar que se ha creado el contenedor, ejecutar
az storage container list \
--account-name <name>

10. Carga de una imagen en la cuenta de Azure Storage

Agregar en Program.cs:

string blobName = "docs-and-friends-selfie-stick";
string fileName = "docs-and-friends-selfie-stick.png";
BlobClient blobClient = container.GetBlobClient(blobName);
blobClient.Upload(fileName, true);

11. Comprobar que ha subido

Agregar en Program.cs:

var blobs = container.GetBlobs();
foreach (var blob in blobs)
{
    Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
}

12. El archivo Program.cs debe verse de la siguiente manera:

using System;
using Microsoft.Extensions.Configuration;
using System.IO;
using Azure.Storage.Blobs;

namespace PhotoSharingApp
{
    class Program
    {
        static void Main(string[] args)
        {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json");

        var configuration = builder.Build();

        Console.WriteLine("Hello World!");

        // Get a connection string to our Azure Storage account.
        var connectionString = configuration.GetConnectionString("StorageAccount");

        // Get a reference to the container client object so you can create the "photos" container
        string containerName = "photos";
        BlobContainerClient container = new BlobContainerClient(connectionString, containerName);
        container.CreateIfNotExists();

        // Uploads the image to Blob storage.  If a blb already exists with this name it will be overwritten
        string blobName = "docs-and-friends-selfie-stick";
        string fileName = "docs-and-friends-selfie-stick.png";
        BlobClient blobClient = container.GetBlobClient(blobName);
        blobClient.Upload(fileName, true);

        // List out all the blobs in the container
        var blobs = container.GetBlobs();
        foreach (var blob in blobs)
        {
            Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
        }
    }
    }
}
