# Publicación de una aplicación web en Azure con Visual Studio

## _¿Qué son las cargas de trabajo de Visual Studio?_
Una carga de trabajo es un paquete preconfigurado de herramientas en Visual Studio que se agrupan para permitir a los desarrolladores crear determinados tipos de aplicaciones, usar determinados lenguajes de desarrollo o desarrollar para plataformas específicas.

Visual Studio 2019 tiene dos cargas de trabajo que necesita para crear, publicar e implementar el sitio web en Azure:

- Desarrollo de ASP.NET y web: La carga de trabajo de desarrollo web en Visual Studio está diseñada para maximizar la productividad al desarrollar aplicaciones web mediante ASP.NET y tecnologías basadas en estándares como HTML y JavaScript.

- Desarrollo de Azure: La carga de trabajo de desarrollo de Azure en Visual Studio instala el último Azure SDK para .NET y herramientas para Visual Studio. Una vez instalados estos elementos, puede ver los recursos en Cloud Explorer, crear recursos mediante las herramientas de Azure Resource Manager, compilar aplicaciones para los servicios web de Azure y Cloud Services, y realizar operaciones de macrodatos mediante herramientas de Azure Data Lake.

### _Creación de un proyecto de ASP.NET Core_
1. En Visual Studio > Crear nueov proyecto > Web >  Aplicación web ASP.NET Core.
2. Ingresar Nombre, seleccionar ubicacion, ASP.NET Core 3.1 o posterior y por ultimo Crear.
3. Presionar F5 para compilar y ejecutar la aplicacion en modo debug.
4. Presionar Ctrl + F5 para compilar y ejecutar la aplicacion sin modo debug. Permite realizar cambios en el código, guardar el archivo, actualizar el explorador y ver los cambios de código

## _Publicación de la aplicación web ASP.NET Core en Azure_ 
1. Botón derecho en el proyecto y seleccione Publicar
2. Seleccionar Azure como destino de publicación y, después, Siguiente para continuar.
3. Seleccionar Azure App Service (Windows) y después Siguiente para continuar.
Las aplicaciones ASP.NET Core son multiplataforma. Esto significa que admiten la ejecución en la versión para Linux de App Service sin cambios de código. Pero la versión de Linux no es compatible con un modelo de hospedaje compartido.
4. Seleccionar suscripcion
5. Crear una instancia de Azure App Service 
6. Seleccionar Finalizar para terminar de crear el perfil de publicación
7. Seleccionar Publicar