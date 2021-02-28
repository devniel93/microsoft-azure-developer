# Compilación y ejecución de una aplicación web con la pila MEAN en una máquina virtual Linux de Azure 
MEAN es una pila de desarrollo para compilar y hospedar aplicaciones web. MEAN es el acrónimo de sus componentes: MongoDB, Express, AngularJS y Node.js.

## _¿Por qué debería elegir MEAN?_
Los componentes de la pila MEAN son confiables, bien conocidos y de código abierto.

- Los datos no están muy estructurados:
MongoDB es lo que se denomina una base de datos NoSQL. Una base de datos NoSQL no necesita que los datos se estructuren de una manera predefinida como lo estarían con una base de datos relacional, como Microsoft SQL Server o MySQL. En su lugar, MongoDB almacena sus datos en documentos similares a JSON que no requieren las estructuras de datos estrictas que necesitan MySQL u otras bases de datos relacionales.

- MEAN está bien documentado:
Todos los componentes de la pila MEAN son populares en la actualidad. Los recursos para trabajar con MongoDB, Express, AngularJS y Node.js son fáciles de encontrar.

- MEAN se ejecuta prácticamente en cualquier entorno:
También puede desarrollar aplicaciones de la pila MEAN desde su entorno de desarrollo favorito, ya sea Windows, macOS o Linux.

¿Por qué MEAN podría no ser la opción adecuada para mí?
- Sus datos están muy estructurados:
Si sus datos están muy estructurados, podría beneficiarse de colocarlos en una base de datos relacional, como Microsoft SQL Server o MySQL.

- JavaScript no es su aptitud principal:
Si prefiere otro lenguaje en lugar de JavaScript, puede haber un marco alternativo a su alcance.
Por ejemplo, puede que la pila LAMP, que consta de Linux, Apache, MySQL y PHP

---

# Creación de una máquina virtual para hospedar una aplicación web

## _Creación de una máquina virtual Ubuntu Linux_s
1. Crear un RG
```
(Example)az group create \
  --name <resource-group-name> \
  --location <resource-group-location>
```

2. Crear un VM
```
az vm create \
  --resource-group learn-d7e4a223-06a0-49c7-b232-532d2d2b9dfc \
  --name MeanStack \
  --image Canonical:UbuntuServer:16.04-LTS:latest \
  --admin-username azureuser \
  --generate-ssh-keys
```

3. Abir puerto 80 para permitir trafico entrante HTTP
```
az vm open-port \
  --port 80 \
  --resource-group learn-d7e4a223-06a0-49c7-b232-532d2d2b9dfc \
  --name MeanStack
```

4. Obtener IP publica
```
ipaddress=$(az vm show \
  --name MeanStack \
  --resource-group learn-d7e4a223-06a0-49c7-b232-532d2d2b9dfc \
  --show-details \
  --query [publicIps] \
  --output tsv)
```

5. Conectarse por SSH
```
ssh azureuser@$ipaddress
```

## _Instalar MongoDB_
1. Actualizar paquetes
```
sudo apt update && sudo apt upgrade -y
```

2. Instalr paquete de MongoDB
```
sudo apt-get install -y mongodb
```

3. Activar servicio para inicio automatico
```
sudo systemctl status mongodb
```

4. Para comprobar que se instalo, ejecutar:
```
mongod --version
```

## _Instalar Node.js_
Node.js actua como el host del lado servidor para la aplicación web y controla el tráfico HTTP entrante. También proporciona una manera de comunicarse con MongoDB

1. Registrar repositorio de Node.js para que el admin de paquetes localice los paquetes de Node.
```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
```

2. Instalar paquete de node
```
sudo apt install nodejs
```

3. Comprobar la instalación
```
nodejs -v
```

## _Creación de una aplicación web básica_
1. Crear carpetas y archivos para la app web
```
cd ~
mkdir Books
touch Books/server.js
touch Books/package.json
mkdir Books/app
touch Books/app/model.js
touch Books/app/routes.js
mkdir Books/public
touch Books/public/script.js
touch Books/public/index.html
```

Donde:
- Books: el directorio raíz del proyecto.
`server.js` define el punto de entrada a la aplicación web. Carga los paquetes de Node.js necesarios, especifica el puerto en el que escuchar y empieza a escuchar el tráfico HTTP entrante.
`package.json` proporciona información sobre la aplicación, como su nombre, descripción y qué paquetes de Node.js debe ejecutar la aplicación.
- Books/app: contiene código que se ejecuta en el servidor.
`model.js` define la conexión de base de datos y el esquema. Piense en ella como el modelo de datos de la aplicación.
`routes.js` controla el enrutamiento de solicitudes. Por ejemplo, define las solicitudes GET al punto de conexión /book al proporcionar la lista de todos los libros de la base de datos.
- Books/public: contiene archivos que se entregan directamente en el explorador del cliente.
`index.html` contiene la página de índice. Contiene un formulario web que permite al usuario enviar información sobre los libros. También muestra todos los libros de la base de datos y le permite eliminar las entradas de la base de datos.
`script.js` contiene el código JavaScript que se ejecuta en el explorador del usuario. Puede enviar solicitudes al servidor para mostrar libros, agregar libros a la base de datos y eliminar libros de la base de datos.

2. Creación del modelo de datos. 
Editar `app/model.js`
```
var mongoose = require('mongoose');
var dbHost = 'mongodb://localhost:27017/Books';
mongoose.connect(dbHost, { useNewUrlParser: true } );
mongoose.connection;
mongoose.set('debug', true);
var bookSchema = mongoose.Schema( {
    name: String,
    isbn: {type: String, index: true},
    author: String,
    pages: Number
});
var Book = mongoose.model('Book', bookSchema);
module.exports = Book;
```

3. Creación de las rutas de Express que controlan las solicitudes HTTP.
Editar `app/route.js`
```
var path = require('path');
var Book = require('./model');
var routes = function(app) {
    app.get('/book', function(req, res) {
        Book.find({}, function(err, result) {
            if ( err ) throw err;
            res.json(result);
        });
    });
    app.post('/book', function(req, res) {
        var book = new Book( {
            name:req.body.name,
            isbn:req.body.isbn,
            author:req.body.author,
            pages:req.body.pages
        });
        book.save(function(err, result) {
            if ( err ) throw err;
            res.json( {
                message:"Successfully added book",
                book:result
            });
        });
    });
    app.delete("/book/:isbn", function(req, res) {
        Book.findOneAndRemove(req.query, function(err, result) {
            if ( err ) throw err;
            res.json( {
                message: "Successfully deleted the book",
                book: result
            });
        });
    });
    app.get('*', function(req, res) {
        res.sendFile(path.join(__dirname + '/public', 'index.html'));
    });
};
module.exports = routes;
```

4. Creación de la aplicación de JavaScript del lado cliente.
Editar `public/script.js`
```
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
    var getData = function() {
        return $http( {
            method: 'GET',
            url: '/book'
        }).then(function successCallback(response) {
            $scope.books = response.data;
        }, function errorCallback(response) {
            console.log('Error: ' + response);
        });
    };
    getData();
    $scope.del_book = function(book) {
        $http( {
            method: 'DELETE',
            url: '/book/:isbn',
            params: {'isbn': book.isbn}
        }).then(function successCallback(response) {
            console.log(response);
            return getData();
        }, function errorCallback(response) {
            console.log('Error: ' + response);
        });
    };
    $scope.add_book = function() {
        var body = '{ "name": "' + $scope.Name +
        '", "isbn": "' + $scope.Isbn +
        '", "author": "' + $scope.Author +
        '", "pages": "' + $scope.Pages + '" }';
        $http({
            method: 'POST',
            url: '/book',
            data: body
        }).then(function successCallback(response) {
            console.log(response);
            return getData();
        }, function errorCallback(response) {
            console.log('Error: ' + response);
        });
    };
});
```

5. Creación de la interfaz del usuario.
Editar `public/index.html`
<!doctype html>
<html ng-app="myApp" ng-controller="myCtrl">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.2/angular.min.js"></script>
    <script src="script.js"></script>
</head>
<body>
    <div>
    <table>
        <tr>
        <td>Name:</td>
        <td><input type="text" ng-model="Name"></td>
        </tr>
        <tr>
        <td>Isbn:</td>
        <td><input type="text" ng-model="Isbn"></td>
        </tr>
        <tr>
        <td>Author:</td>
        <td><input type="text" ng-model="Author"></td>
        </tr>
        <tr>
        <td>Pages:</td>
        <td><input type="number" ng-model="Pages"></td>
        </tr>
    </table>
    <button ng-click="add_book()">Add</button>
    </div>
    <hr>
    <div>
    <table>
        <tr>
        <th>Name</th>
        <th>Isbn</th>
        <th>Author</th>
        <th>Pages</th>
        </tr>
        <tr ng-repeat="book in books">
        <td><input type="button" value="Delete" data-ng-click="del_book(book)"></td>
        <td>{{book.name}}</td>
        <td>{{book.isbn}}</td>
        <td>{{book.author}}</td>
        <td>{{book.pages}}</td>
        </tr>
    </table>
    </div>
</body>
</html>

6. Creación del servidor de Express que hospedará la aplicación. 
Editar `server.js`
```
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json());
require('./app/routes')(app);
app.set('port', 80);
app.listen(app.get('port'), function() {
    console.log('Server up: http://localhost:' + app.get('port'));
});
```

7. Definición de las dependencias y la información del paquete.
Editar `package.json`
```
{
  "name": "books",
  "description": "Sample web app that manages book information.",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/..."
  },
  "main": "server.js",
  "dependencies": {
    "express": "~4.16",
    "mongoose": "~5.3",
    "body-parser": "~1.18"
  }
}
```

8. Copiar los archivos en la VM
```
scp -r ~/Books azureuser@$ipaddress:~/Books
```

9. Instalación de los paquetes adicionales de Node
```
ssh azureuser@$ipaddress
cd ~/Books
sudo apt install npm
npm install
```

10. Probar la aplicacion
```
sudo nodejs server.js
```