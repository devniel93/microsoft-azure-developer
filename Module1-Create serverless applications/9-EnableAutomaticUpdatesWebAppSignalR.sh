Habilitar las actualizaciones automáticas en una aplicación web 
mediante Azure Functions y SignalR Service

The demo lab on
labs-azure\serverless-demo

1. Clonar repo git en VS Code
git clone https://github.com/MicrosoftDocs/mslearn-advocates.azure-functions-and-signalr.git serverless-demo


2. Crear una cuenta de Storage

Ejecutar en una terminal 
export STORAGE_ACCOUNT_NAME=mslsigrstorage$(openssl rand -hex 5)
echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"

Storage Account
mslsigrstoragee1e7ac7f94

az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
  --kind StorageV2 \
  --sku Standard_LRS

3. Crear cuenta de Azure Cosmos DB

Ejecutar en una terminal 
az cosmosdb create  \
  --name msl-sigr-cosmos-$(openssl rand -hex 5) \
  --resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9

4. Actualizar configuracion local

Ejecutar en una terminal para obtener cadenas de conexion de 
los recursos creados:

STORAGE_CONNECTION_STRING=$(az storage account show-connection-string \
--name $(az storage account list \
  --resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
  --query [0].name -o tsv) \
--resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
--query "connectionString" -o tsv)

COSMOSDB_ACCOUNT_NAME=$(az cosmosdb list \
    --resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
    --query [0].name -o tsv)

COSMOSDB_CONNECTION_STRING=$(az cosmosdb list-connection-strings  \
  --name $COSMOSDB_ACCOUNT_NAME \
  --resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
  --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" -o tsv)

COSMOSDB_MASTER_KEY=$(az cosmosdb list-keys \
--name $COSMOSDB_ACCOUNT_NAME \
--resource-group learn-24c2aed2-8c62-4a4c-9caa-55735b20c2b9 \
--query primaryMasterKey -o tsv)

printf "\n\nReplace <STORAGE_CONNECTION_STRING> with:\n$STORAGE_CONNECTION_STRING\n\nReplace <COSMOSDB_CONNECTION_STRING> with:\n$COSMOSDB_CONNECTION_STRING\n\nReplace <COSMOSDB_MASTER_KEY> with:\n$COSMOSDB_MASTER_KEY\n\n"

$STORAGE_CONNECTION_STRING
$COSMOSDB_ACCOUNT_NAME
$COSMOSDB_CONNECTION_STRING
$COSMOSDB_MASTER_KEY

5. Editar el archivo local.settings.json y actualizar las 
variables
AzureWebJobsStorage, AzureCosmosDBConnectionString y 
AzureCosmosDBMasterKey

6. Ejecutar 
npm install

7. Presionar F5 para iniciar debug de la aplicacion start 
Se necesitara tener instalado la extension de Azure Funcion en
VS Code

8. Ejecutar la web aplicacion localmente
npm start

9. Realizar una prueba de actualizacion de datos para comprobar 
que despues de unos segundos los datos son actualizados
npm run update-data





