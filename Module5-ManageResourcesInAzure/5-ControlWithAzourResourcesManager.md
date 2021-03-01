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

---

## _¿Qué son las etiquetas?_
Son pares de nombre/valor de datos de texto que se pueden aplicar a recursos y grupos de recursos. Un recurso puede tener hasta 50 etiquetas. El nombre está limitado a 512 caracteres para todos los tipos de recursos, excepto las cuentas de almacenamiento, que tienen un límite de 128 caracteres. El límite del valor de una etiqueta es de 256 caracteres para todos los tipos de recursos.  No todos los tipos de recursos admiten etiquetas.

Para agregar una etiqueta:
```
az resource tag --tags Department=Finance \
    --resource-group msftlearn-core-infrastructure-rg \
    --name msftlearn-vnet1 \
    --resource-type "Microsoft.Network/virtualNetworks"
```