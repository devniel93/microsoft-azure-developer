Qué es Azure Functions Core Tools
Conjunto de herramientas de línea de comandos que se puede usar para 
desarrollar y probar funciones de Azure Functions en el equipo local.

- Generar los archivos y las carpetas necesarios para desarrollar funciones 
en el equipo local
- Ejecutar las funciones de forma local para poder probarlas y depurarlas
- Publicar las funciones en Azure

Core Tools se empaqueta como una única utilidad de línea de comandos 
denominada "func".

Creación de un proyecto de Functions con func init
1. Instalar func-cli 
2. Ejecutar en el terminal
func init
seleccionar worker runtime:node
selecionar lenguaje: javascript

3. Crear funcion. Ejecutar en el terminal
func new 
seleccionar opcion 8 HttpTrigger
ingresar un nombre de funcion

4. Para iniciar el host de Functions en entorno local
Ejecutar en terminal
func start

Para ejecutar en segundo plano:
func start &> ~/output.txt &

Para matar la funcion
pkill func

5. Crear un Function App

RESOURCEGROUP=learn-1ba16544-e455-41ec-ac6e-e5da11f2fe50
STORAGEACCT=learnstorage$(openssl rand -hex 5)
FUNCTIONAPP=learnfunctions$(openssl rand -hex 5)

az storage account create \
  --resource-group "$RESOURCEGROUP" \
  --name "$STORAGEACCT" \
  --kind StorageV2 \
  --location centralus

az functionapp create \
  --resource-group "$RESOURCEGROUP" \
  --name "$FUNCTIONAPP" \
  --storage-account "$STORAGEACCT" \
  --runtime node \
  --consumption-plan-location centralus \
  --functions-version 2


6. Publicar en Azure
cd ~/loan-wizard
func azure functionapp publish "$FUNCTIONAPP"




