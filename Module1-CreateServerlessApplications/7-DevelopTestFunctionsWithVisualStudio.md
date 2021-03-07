# Desarrollo, Prueba y Despliegue de una Funcion con Visual Studio

## _Laboratorio en local con Visual Studio_

1. Instalar Visual Studio Community 2019
https://visualstudio.microsoft.com/downloads/

Seleccionar ASP.NET y Azure Development en Workloads 

* Azure ofrece tres versiones del entorno de ejecución necesario para ejecutar Azure Functions. 
La versión 1 (v1) usa .NET Framework 4.7; 
La versión 2 (v2x) se ejecuta con .NET Core 2; 
La versión 3 (v3x) contiene cambios de JavaScript y .NET. 
El uso de desencadenadores de v2 permite desarrollar y hospedar el desencadenador en distintos entornos. Los desencadenadores de versión 1 solo pueden crearse con Windows. 

2. Crear nuevo proyecto de tipo Azure Functions
Asegurarse de NO seleccionar que la solucion y el proyecto este en la misma ruta.

3. Crear nueva Azure Functions applications 
Seleccionar el Storage Account
Seleccionar el Authorization level

4. Probar la funcion localmente
Seleccionar Debug 
Visual Studio compilara la aplicacion de Azure Functions y brindara HTTP URLs disponibles por cada funcion
Se puede incluir breakpoints para debugear en Visual Studio

---

## _Publicacion de una funcion_
Una instancia de Azure Functions se ejecuta en la nube en el contexto de una aplicación de Azure Functions.
Una aplicación de función es un contenedor que especifica el SO para ejecutar una función de Azure, junto con los recursos, como la memoria, la potencia de computación y el espacio en disco. 
Una aplicación de Azure Functions es una colección de una o más máquinas virtuales (VM) que se ejecutan en un servidor web. Cuando se publica una función de Azure, se implementa en estas máquinas virtuales.

- Implementación desde Visual Studio
Las herramientas de Azure Functions para Visual Studio permiten implementar una función de Azure directamente desde Visual Studio. La plantilla de Azure Functions ofrece un Asistente para publicación.

- Implementación continua
Azure Functions facilita la implementación de la aplicación de función con la integración continua de App Service. Azure Functions se integra con BitBucket, Dropbox, GitHub y Azure DevOps. 

- Implementación de archivos ZIP
Azure Functions se puede implementar desde un archivo ZIP mediante la técnica de implementación de inserción. Puede hacerlo con la CLI de Azure o mediante la interfaz de REST. El archivo ZIP contiene el código ejecutable para las funciones. La implementación de archivos ZIP copia estos archivos en la carpeta `wwwwroot` de la aplicación de función.

```
az functionapp deployment source config-zip \
-g <resource-group> \
-n <function-app-name> \
--src <zip-file>
```

1. Crear una aplicacion de Azure Functions en Azure Portal
Crear nuevo recurso Compute > Function App

2. Implementar la funcion creada en la aplicacion de Azure Functions
En Visual Studio, seleccionar el proyecto de Funcion y seleccionar > Publicar
Seleccionar Azure
Seleccionar el grupo de recursos 
Seleccionar agregar Function App y Crear.
Seleccionar Publica.

En la ventana de Output del Visual Studio debe salir Publicacion correcta
y publicacion completada.

3. Comprobar implementacion de funciones
Seleccionar el Function App Name creado 
Asegurarse que apunte al storage account correcto 
Validar la url de la funcion 
https://watchfunctions-devniel93.azurewebsites.net/api/watchinfo?model=devniel93

---

## _Prueba Unitaria de una funcion_

1. Crear nuevo proyecto de pruebas
En Visual Studio, en LA SOLUCION agregar nuevo proyecto de 
tipo xUnit Test Project.

2. Click derecho sobre el nuevo proyecto y seleccionar Manage NuGet Packages.

3. Buscar el paquete `Microsoft.AspNetCore.Mvc` e Instalar. Este paquete creara un entorno simulado de HTTP.

4. Click derecho sobre el archivo `UnitTest1.cs` para cambiar el nombre de la prueba y confirmar para cambiar el nombre en todas las referencias.

5. Click derecho sobre el proyecto de pruebas agregar Referencia el proyecto de la funcion

6. Incorporar pruebas unitarias a la funcion
Editar el archivo de pruebas y agregar los siguientes metodos:
```
[Fact]
public void TestWatchFunctionSuccess()
{
    var queryStringValue = "abc";
    var request = new DefaultHttpRequest(new DefaultHttpContext())
    {
        Query = new QueryCollection
        (
            new System.Collections.Generic.Dictionary<string, StringValues>()
            {
                { "model", queryStringValue }
            }
        )
    };
    var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");
    var response = WatchPortalFunction.WatchInfo.Run(request, logger);
    response.Wait();

    // Check that the response is an "OK" response
    Assert.IsAssignableFrom<OkObjectResult>(response.Result);

    // Check that the contents of the response are the expected contents
    var result = (OkObjectResult)response.Result;
    dynamic watchinfo = new { Manufacturer = "abc", CaseType = "Solid", Bezel = "Titanium", Dial = "Roman", CaseFinish = "Silver", Jewels = 15 };
    string watchInfo = $"Watch Details: {watchinfo.Manufacturer}, {watchinfo.CaseType}, {watchinfo.Bezel}, {watchinfo.Dial}, {watchinfo.CaseFinish}, {watchinfo.Jewels}";
    Assert.Equal(watchInfo, result.Value);

}

[Fact]
public void TestWatchFunctionFailureNoQueryString()
{
    var request = new DefaultHttpRequest(new DefaultHttpContext());
    var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");

    var response = WatchPortalFunction.WatchInfo.Run(request, logger);
    response.Wait();

    // Check that the response is an "Bad" response
    Assert.IsAssignableFrom<BadRequestObjectResult>(response.Result);

    // Check that the contents of the response are the expected contents
    var result = (BadRequestObjectResult)response.Result;
    Assert.Equal("Please provide a watch model in the query string", result.Value);
}

[Fact]
public void TestWatchFunctionFailureNoModel()
{
    var queryStringValue = "abc";
    var request = new DefaultHttpRequest(new DefaultHttpContext())
    {
        Query = new QueryCollection
        (
            new System.Collections.Generic.Dictionary<string, StringValues>()
            {
                { "not-model", queryStringValue }
            }
        )
    };

    var logger = NullLoggerFactory.Instance.CreateLogger("Null Logger");

    var response = WatchPortalFunction.WatchInfo.Run(request, logger);
    response.Wait();

    // Check that the response is an "Bad" response
    Assert.IsAssignableFrom<BadRequestObjectResult>(response.Result);

    // Check that the contents of the response are the expected contents
    var result = (BadRequestObjectResult)response.Result;
    Assert.Equal("Please provide a watch model in the query string", result.Value);
}
```
7. Ejecutar desde la opcion Test > Todas las pruebas