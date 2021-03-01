# Automatización de tareas de Azure mediante scripts con PowerShell
La creación de scripts de administración es una manera eficaz de optimizar el flujo de trabajo. Puede automatizar tareas comunes y repetitivas y, una vez comprobado un script, este se ejecutará constantemente, lo que probablemente reduzca los errores.

## _¿Qué es Azure PowerShell?_
Es un módulo que se agrega a Windows PowerShell o PowerShell Core para permitirle conectarse a la suscripción de Azure y administrar recursos. Azure PowerShell requiere PowerShell para funcionar. Está disponible de dos formas: dentro de un explorador mediante Azure Cloud Shell o con una instalación local en Linux, Mac o Windows.  

## _Elección de una herramienta administrativa_
- Automatización: ¿necesita automatizar un conjunto de tareas repetitivas o complejas? Azure PowerShell y la CLI de Azure sí lo permiten, pero Azure Portal no.

- Curva de aprendizaje: ¿necesita completar una tarea rápidamente sin aprender nuevos comandos o sintaxis? Azure Portal no requiere el aprendizaje de sintaxis o la memorización de comandos. En Azure PowerShell y en la CLI de Azure, debe conocer la sintaxis detallada de cada comando que use.

- Conjunto de aptitudes del equipo: ¿el equipo tiene experiencia? Por ejemplo, el equipo puede haber usado PowerShell para administrar Windows. En su caso, sus miembros se familiarizarán rápidamente con el uso de Azure PowerShell.

## _Instalación de Azure PowerShell_
Se necesitan 2 componentes:
- El producto básico de PowerShell. Se presenta en dos variantes: PowerShell para Windows y PowerShell Core para macOS y Linux.

- El módulo Azure PowerShell. Este módulo adicional debe estar instalado para agregar los comandos específicos de Azure en PowerShell.

* PowerShell se incluye con Windows (pero puede que haya una actualización disponible). Tendrá que instalar PowerShell Core en Linux y macOS.

Para ver la version de PowerShell en Windows:
```
$PSVersionTable.PSVersion
```

Si es una version menor a 5.0, se debe actualizar.