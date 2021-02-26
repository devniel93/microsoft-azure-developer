# Almacenamiento de datos de aplicaciones con Azure Blob Storage

## _Blob Storage_
Los blobs brindan almacenamiento de archivos en la nube y una API que permite compilar aplicaciones para acceder a los datos.

Azure Blob Storage es no estructurado, lo que significa que no hay ninguna restricción sobre los tipos de datos que puede contener, por lo que un blob puede contener un PDF, JPG,, JSON, VIdeo, etc.

Los blobs no son adecuados para datos estructurados porque su latencia es mayor que la memoria y disco local y no tiene indexacion para hacer mas eficaces la ejecución de consultas. Pero los blobs pueden usarse junto a una base de datos estructurada en forma de guardar una url o identificador del blob en una de las columnas.

## _Storage Account, Contenedores y Metadatos
En el Blob Storage, los blobs se encuentran dentro de un contenedor de blobs. Un Storage account puede almacenar blobs ilimitados en un contenedor y tener un número ilimitado de contenedores. 

Los contenedores y blobs admiten metadatos en format de pares de cadena clave-valor, lo que sirve para tener una descripción del blob por ejemplo.

---

# Diseño de una estrategia de organización de almacenamiento
Al diseñar una aplicación que necesita almacenar los datos, es importante pensar en cómo la aplicación va a organizarlos en blobs, contenedores y cuentas de almacenamiento.

## _Cuentas de almacenamiento_
Usar una sola Storage Account puede ser suficiente para organizar blobs como se desee pero se debería usar más cuentas de almacenamiento para separar costos y controlar el accesos.

## _Limitaciones sobre nomenclatura_
Los nombres de contenedores y blobs deben seguir una serie de reglas, como las limitaciones de longitud y las restricciones de caracteres.

## _Acceso público y contenedores como límites de seguridad_
De forma predeterminada, todos los blobs requieren autenticación para acceder. Sin embargo, los contenedores individuales pueden configurarse para permitir la descarga pública de sus blobs sin autenticación. Los blobs de un contenedor configurado con acceso público los puede descargar cualquier persona que conozca las URL de almacenamiento sin ningún tipo de autenticación o auditoría. No se debe colcar los datos de blob en un contenedor público si no se desea compartirlos públicamente.

---

# Creación de recursos de Azure Storage

1. Para crear la cuenta de almacenamiento, ejecutar:

```
az storage account create \
  --kind StorageV2 \
  --resource-group learn-ddccdcbf-a785-4b03-9df8-fd906366e320 \
  --location centralus \
  --name mystgaccountdevniel93
```
2. Clonar aplicación de ejemplo
```
git clone https://github.com/MicrosoftDocs/mslearn-store-data-in-azure.git
cd mslearn-store-data-in-azure/store-app-data-with-azure-blob-storage/src/start
code .
```

3. Agregar una referencia al SDK de Azure Storage:
```
dotnet add package WindowsAzure.Storage
dotnet restore
```

4. Inicializar contenedor. Editar _Models/BlobStorage.cs_

Agregar:
```
using System.Linq;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
```

Modificar el metodo _Initialize()_:
```
public Task Initialize()
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    return container.CreateIfNotExistsAsync();
}
```

5. Para obtener una lista de blobs,se puede usar el siguiente patron para enumerar todos los blos del contenedor

Editar el metodo GetNames del archivo _BlobStorage.cs_:

```
public async Task<IEnumerable<string>> GetNames()
{
    List<string> names = new List<string>();

    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);

    BlobContinuationToken continuationToken = null;
    BlobResultSegment resultSegment = null;

    do
    {
        resultSegment = await container.ListBlobsSegmentedAsync(continuationToken);

        // Get the name of each blob.
        names.AddRange(resultSegment.Results.OfType<ICloudBlob>().Select(b => b.Name));

        continuationToken = resultSegment.ContinuationToken;
    } while (continuationToken != null);

    return names;
}
```

6. Para cargar un blob

Editar el metodo _Save_ el archivo _BlobStorage.cs_
```
public Task Save(Stream fileStream, string name)
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    CloudBlockBlob blockBlob = container.GetBlockBlobReference(name);
    return blockBlob.UploadFromStreamAsync(fileStream);
}
```

7. Para descargar un blob

Editar el metodo _Load_ el archivo _BlobStorage.cs_
```
public Task<Stream> Load(string name)
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    return container.GetBlobReference(name).OpenReadAsync();
}
```
8. Crear una aplicacion de App Service
```
az appservice plan create \
--name blob-exercise-plan \
--resource-group learn-ddccdcbf-a785-4b03-9df8-fd906366e320 \
--sku FREE --location centralus
```

9. Crear web app
```
az webapp create \
--name mywebappdevniel93 \
--plan blob-exercise-plan \
--resource-group learn-ddccdcbf-a785-4b03-9df8-fd906366e320
```

10. Obtener cadena de conexion del Storage Account
```
az storage account show-connection-string --name mystgaccountdevniel93
```

11. Configurar conexion en web app
```
az webapp config appsettings set \
--name mywebappdevniel93 --resource-group learn-ddccdcbf-a785-4b03-9df8-fd906366e320 \
--settings AzureStorageConfig:ConnectionString=$CONNECTIONSTRING AzureStorageConfig:FileContainerName=files
```

12. Implementar el web app
```
dotnet publish -o pub
cd pub
zip -r ../site.zip *
```

13. Desplegar web app 
```
az webapp deployment source config-zip \
--src ../site.zip \
--name mywebappdevniel93 \
--resource-group learn-ddccdcbf-a785-4b03-9df8-fd906366e320
```

14. Para ver la aplicacion en ejecucion, abrir en el browser:
`https://mywebappdevniel93.azurewebsites.net/`

15. Intentar cargar y descargar archivos para probar el web app
```
az storage blob list --account-name mywebappdevniel93 --container-name files --query [].{Name:name} --output table
```