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

---

## _¿Qué es Azure Policy?_
 es un servicio que se puede usar para crear, asignar y administrar directivas. Estas directivas aplican las reglas que los recursos deben seguir. Estas directivas pueden aplicar estas reglas cuando se crean los recursos y se pueden evaluar con respecto a los recursos existentes para ofrecer visibilidad sobre el cumplimiento normativo.

 Las directivas pueden exigir, por ejemplo, que solo se permita la creación de determinados tipos de recursos, o bien que solo se permitan los recursos de regiones de Azure concretas. También puede exigir que se apliquen etiquetas específicas a los recursos.

 ### Uso de directivas para aplicar estándares
Se podria usar directivas para restringir las regiones de Azure en las que puede implementar recursos por temas de restricciones legales o normativas sobre dónde pueden residir los datos. Ademas, se podrían usar para restringir los tipos de tamaños de máquina virtual que se pueden implementar. Tambien, se podría usar las directivas para aplicar convenciones de nomenclatura para mantener un estándar de nomenclatura coherente entre los recursos de Azure.

---

## Protección de los recursos con el control de acceso basado en rol (RBAC)_
RBAC proporciona la administración de acceso específico para los recursos de Azure, lo que permite conceder a los usuarios los derechos específicos necesarios para realizar sus trabajos. RBAC se considera un servicio central y se incluye con todos los niveles de suscripción sin costo alguno.

Con RBAC, puede:

- Permitir que un usuario administre las máquinas virtuales de una suscripción y que otro usuario administre las redes virtuales.
- Permitir a un grupo de administradores de base de datos (DBA) administrar bases de datos SQL en una suscripción.
- Permitir que un usuario administre todos los recursos de un grupo de recursos, como las máquinas virtuales, los sitios web y las subredes virtuales.
- Permitir que una aplicación acceda a todos los recursos de un grupo de recursos.

Para ver los permisos de acceso, usar el panel Control de acceso (IAM) en Azure Portal. 

### Procedimientos recomendados para RBAC
- Al planear la estrategia de control de acceso, conceder a los usuarios el nivel de privilegios mínimo que necesitan para realizar su trabajo.
- Usar Bloqueos de recursos para asegurar que los recursos críticos no se modifican ni eliminan.