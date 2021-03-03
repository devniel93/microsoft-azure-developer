# Escalado de una aplicación web de App Service para satisfacer la demanda de forma eficaz con el escalado vertical y horizontal de App Service
Es importante escalar una aplicación web por estos motivos:
- Permite que la aplicación web siga respondiendo durante períodos de gran demanda.
- Se ahorra más porque reduce los recursos necesarios cuando la demanda disminuye.

## _Escalado manual de una aplicación web_
Al realizar de forma manual un escalado horizontal y después una reducción horizontal, podrá responder a las previsiones de aumento y disminución del tráfico. El escalado horizontal tiene la ventaja adicional de que aumenta la disponibilidad, debido al mayor número de instancias de la aplicación web.

### Planes de App Service y escalabilidad
Las aplicaciones web que se ejecutan en Azure suelen usar Azure App Service para proporcionar el entorno de hospedaje. App Service puede organizar la ejecución de varias instancias de la aplicación web y cada instancia se ejecuta en una VM. Los recursos de cada VM se definen el plan de App Service segun la siguiente lista:
- El nivel Gratis ofrece 1 GB de espacio en disco y soporte técnico para un máximo de 10 aplicaciones, pero una sola instancia compartida y ningún Acuerdo de Nivel de Servicio de disponibilidad. Cada aplicación tiene una cuota de proceso de 60 minutos al día. El plan de servicio Gratis es adecuado principalmente para el desarrollo y la prueba de aplicaciones, en lugar de para implementaciones de producción.
- El nivel Compartido ofrece compatibilidad con más aplicaciones (hasta 100) y también se ejecuta en una sola instancia compartida. Las aplicaciones tienen una cuota de proceso de 240 minutos al día. No hay ningún Acuerdo de Nivel de Servicio de disponibilidad.
- El nivel Básico es compatible con un número ilimitado de aplicaciones y proporciona más espacio en disco. Las aplicaciones se pueden escalar horizontalmente a tres instancias dedicadas. Este nivel proporciona un Acuerdo de Nivel de Servicio de disponibilidad del 99,95 %. Este nivel ofrece tres opciones con diferentes cantidades de potencia de proceso, memoria y almacenamiento en disco.
- El nivel Estándar también admite un número ilimitado de aplicaciones. Se puede escalar a 10 instancias dedicadas y tiene un Acuerdo de Nivel de Servicio de disponibilidad del 99,95 %. Al igual que el nivel Básico, este ofrece tres opciones con un conjunto de características cada vez más eficaces de proceso, memoria y disco.
- El nivel Premium ofrece hasta 20 instancias dedicadas, un Acuerdo de Nivel de Servicio de disponibilidad del 99,95 % y varios niveles de hardware.
- El nivel Aislado se ejecuta en una red virtual de Azure dedicada, lo que proporciona aislamiento de red y de proceso. Se puede escalar horizontalmente a 100 instancias y tiene un Acuerdo de Nivel de Servicio de disponibilidad del 99,95 %.

### Supervisión y escalado de una aplicación web
Al crear una aplicación web, puede crear un plan de App Service o usar uno existente. Si selecciona un plan existente, las demás aplicaciones web que lo usen compartirán los recursos con su aplicación web. 

Para realizar el escalado horizontal, debe agregar más instancias a un plan de App Service, hasta el límite disponible para el nivel seleccionado. 

El rendimiento de una aplicación web se supervisa mediante las métricas disponibles para App Service. Si se observa un aumento constante en el uso de recursos, como el uso de la CPU, la ocupación de la memoria o la longitud de cola de disco, se debe realizar un escalado horizontal antes de que estas métricas alcancen un punto crítico. Si las métricas indican que el sistema tiene poca carga y dispone de una gran cantidad de capacidad de reserva, se podria reducir horizontalmente para limitar los costes.

### Creación de un plan de App Service y de una aplicación web y escalado horizontal
1. En Azure Portal > crear Web App 

2. Ingresar Suscripcion, RG, Name, Codigo, .NET Core 3.1, Windows, dejar por default el Plan de App Service > Crear

3. Clonar proyecto Git de ejemplo
```
git clone https://github.com/MicrosoftDocs/mslearn-hotel-reservation-system.git
```

4. Construir la aplicacion y prepararla para la publicacion
```
cd mslearn-hotel-reservation-system/src
dotnet build
cd HotelReservationSystem
dotnet publish -o website
```

5. Comprimir para publicar la implementacion en aplicacion web
```
cd website
zip website.zip *
az webapp deployment source config-zip --src website.zip --name <your-webapp-name> --resource-group mslearn-scale
```

6. Editar el archivo App.config y reemplazar la direcion URL del web app
```
cd ~/mslearn-hotel-reservation-system/src/HotelReservationSystemTestClient
code App.config

<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <appSettings>
        <add key="NumClients" value="100" />
        <add key="ReservationsServiceURI" value="https://<your-webapp-name>.azurewebsites.net/"/>
        <add key="ReservationsServiceCollection" value="api/reservations"/>
    </appSettings>
</configuration>
```

7. Recompilar y correr la aplicacion. Se veran errores HTTP 408 por tiempo de expiracion ya que la respuesta son elntas debido a que se estan conectando 100 clientes simultaneamente.
```
dotnet build
dotnet run
```

8. En Supervision > seleccionar Metricas > Agregar metricas de tiempo CPU, errores servidor HTTP, HTTP4xx, tiempo medio de respuesta. Todos con la agregacion de Suma. Esto permitira ver el rendimiento del CPU, la cantidad de errores de servidor HTTP, el tiempo promedio de respuesta.

9. en Configuracion > Escalar horizontalmente > Establecer recuento de instancias en 5. Al ver las metricas se vera una mejora ya que hay 5 veces mas potencia en CPU.