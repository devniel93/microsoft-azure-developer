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