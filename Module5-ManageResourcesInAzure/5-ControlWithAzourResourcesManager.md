# Control y organización de los recursos de Azure con Azure Resource Manager

## _¿Qué son los grupos de recursos?_
Son un elemento fundamental de la plataforma Azure. Un grupo de recursos es un contenedor lógico para recursos implementados en Azure. Todos los recursos deben estar en un grupo de recursos, y un recurso solo puede ser miembro de un único grupo de recursos. Todos los recursos deben estar en un grupo de recursos, y un recurso solo puede ser miembro de un único grupo de recursos. Los grupos de recursos no se pueden anidar. 

### Ciclo de vida
Si se elimina un grupo de recursos, también se eliminarán todos los recursos que contenga.

### Autorización
Los RG son un ámbito para aplicar permisos de control de acceso basado en roles (RBAC). 

## _Principios de organización_
Los grupos de recursos se pueden organizar de varias formas:
- Por tipo de recurso: Por ejemplo, todas las redes virtuales podrian estar en un grupo de recursos, todas las máquinas virtuales en otro y todas las instancias de Azure Cosmos DB en un tercer grupo.
- Por entorno (producción, pruebas y desarrollo).
- Por departamento (Marketing, Finanzas, Recursos Humanos).
- Combinación de estas estrategias y organizar por entorno y departamento