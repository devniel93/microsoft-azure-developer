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

#########

Using SignalR

- SignalR es una abstracción de una serie de tecnologías que permite a la 
aplicación disfrutar de comunicación bidireccional entre el cliente y el 
servidor. SignalR controla automáticamente la administración de conexiones y 
permite difundir mensajes a todos los clientes conectados de forma simultánea, 
como un salón de chat.

- Una ventaja fundamental de la abstracción que ofrece SignalR es la manera en 
que admite reservas de "transporte". Un transporte es la forma de comunicación 
entre el cliente y el servidor. Las conexiones de SignalR comienzan con una 
solicitud HTTP estándar. Cuando el servidor evalúa la conexión, se selecciona 
el método de comunicación más adecuado (transporte). 

- La capa de abstracción que ofrece SignalR proporciona dos ventajas a la 
aplicación. La primera es la perdurabilidad de la aplicación. A medida que la 
web evoluciona y surgen API superiores a WebSockets, no es necesario cambiar la 
aplicación.

- La segunda ventaja es que SignalR permite que la aplicación se degrade gradualmente 
según las tecnologías compatibles del cliente. Si no admite WebSockets, se usa 
Server Sent Events. Si el cliente no puede controlar Server Sent Events, usa 
sondeo largo de Ajax y así sucesivamente.

# Crear una cuenta de SignalR

1. Obtener un nombre de SignalR

SIGNALR_SERVICE_NAME=msl-sigr-signalr$(openssl rand -hex 5)
az signalr create \
  --name $SIGNALR_SERVICE_NAME \
  --resource-group learn-df81609e-4503-48bd-8b35-45302d7998d8 \
  --sku Free_DS2 \
  --unit-count 1

2. Actualizar modo de servicio
az resource update \
  --resource-type Microsoft.SignalRService/SignalR \
  --name $SIGNALR_SERVICE_NAME \
  --resource-group learn-df81609e-4503-48bd-8b35-45302d7998d8 \
  --set properties.features[flag=ServiceMode].value=Serverless

3. Obtener cadena de conexion de SignalR

SIGNALR_CONNECTION_STRING=$(az signalr key list \
  --name $(az signalr list \
    --resource-group learn-df81609e-4503-48bd-8b35-45302d7998d8 \
    --query [0].name -o tsv) \
  --resource-group learn-df81609e-4503-48bd-8b35-45302d7998d8 \
  --query primaryConnectionString -o tsv)

printf "\n\nReplace <SIGNALR_CONNECTION_STRING> with:\n$SIGNALR_CONNECTION_STRING\n\n" 

4. Actualizar el archivo local.setting.json con la cadena de conexion
en la propiedad AzureSignalRConnectionString 

5. Crear funcion de Azure por Visual Code de tipo HTTP Trigger con nombre
negotiate y nivel de autorizacion Anonymous

6. En negotiate/function.json agregar el siguiente Binding

{
    "type": "signalRConnectionInfo",
    "name": "connectionInfo",
    "hubName": "stocks",
    "direction": "in",
    "connectionStringSetting": "AzureSignalRConnectionString"
}

7. Actualizar en negotiate/index.js

module.exports = async function (context, req, connectionInfo) {
    context.res.body = connectionInfo;
};

8. Crear nueva funcion de Azure de tipo Cosmos DB Trigger con nombre 
stocksChanged, configuracion de aplicacion: AzureCosmosDBConnectionString,
nombre de BD: stocksdb, nombre de coleccion: stocks, nombre de colecion 
de concesiones: leases, crear coleccion si no existe: true

9. En stocksChanged/function.json agregar la siguiente propiedad
"feedPollDelay": 500

Y anexar el siguiente Binding
{
  "type": "signalR",
  "name": "signalRMessages",
  "connectionString": "AzureSignalRConnectionString",
  "hubName": "stocks",
  "direction": "out"
}

10. Actualiazr el archivo stocksChanged/index.js

module.exports = async function (context, documents) {
    const updates = documents.map(stock => ({
        target: 'updated',
        arguments: [stock]
    }));

    context.bindings.signalRMessages = updates;
    context.done();
}

11. Acualizar public/index.html en la secion del div="app"
<div id="app" class="container">
    <h1 class="title">Stocks</h1>
    <div id="stocks">
        <div v-for="stock in stocks" class="stock">
            <transition name="fade" mode="out-in">
                <div class="list-item" :key="stock.price">
                    <div class="lead">{{ stock.symbol }}: ${{ stock.price }}</div>
                    <div class="change">Change:
                        <span
                            :class="{ 'is-up': stock.changeDirection === '+', 'is-down': stock.changeDirection === '-' }">
                            {{ stock.changeDirection }}{{ stock.change }}
                        </span>
                    </div>
                </div>
            </transition>
        </div>
    </div>
</div>

12. Incluir script justo encima de la referencia a index.html.js.
<script src="https://cdn.jsdelivr.net/npm/@aspnet/signalr@1.1.0/dist/browser/signalr.js"></script>

13. Actualizar el archivo public/index.html.js
const LOCAL_BASE_URL = 'http://localhost:7071';
const REMOTE_BASE_URL = '<FUNCTION_APP_ENDPOINT>';

const getAPIBaseUrl = () => {
    const isLocal = /localhost/.test(window.location.href);
    return isLocal ? LOCAL_BASE_URL : REMOTE_BASE_URL;
}

const app = new Vue({
    el: '#app',
    data() {
        return {
            stocks: []
        }
    },
    methods: {
        async getStocks() {
            try {
                const apiUrl = `${getAPIBaseUrl()}/api/getStocks`;
                const response = await axios.get(apiUrl);
                app.stocks = response.data;
            } catch (ex) {
                console.error(ex);
            }
        }
    },
    created() {
        this.getStocks();
    }
});

const connect = () => {
    const connection = new signalR.HubConnectionBuilder()
                            .withUrl(`${getAPIBaseUrl()}/api`)
                            .build();

    connection.onclose(()  => {
        console.log('SignalR connection disconnected');
        setTimeout(() => connect(), 2000);
    });

    connection.on('updated', updatedStock => {
        const index = app.stocks.findIndex(s => s.id === updatedStock.id);
        app.stocks.splice(index, 1, updatedStock);
    });

    connection.start().then(() => {
        console.log("SignalR connection established");
    });
};

connect();
...

14. Depurar la app con F5

15. En una nueva terminal ejecutar para que corra localhost:8080
npm start 

16. Ejecutar update para comprobar la actualizacion en la web
npm run update-data




