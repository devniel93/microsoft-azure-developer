# Traslado de recursos de Azure a otro grupo de recursos

## _Comprobación de las limitaciones en los tipos de recursos_
Se debe investigar si se pueden trasladar y qué restricciones podrían aplicarse. Se puede comprobar los tipos de recursos en la lista Compatibilidad con la operación de traslado para recursos (https://docs.microsoft.com/es-es/azure/azure-resource-manager/management/move-support-resources)

Pueden trasladarse estos recursos:
- Cuentas de Azure Storage
- Máquinas virtuales de Azure
- Redes virtuales de Azure

Estos recursos no se pueden trasladar:
- Azure Active Directory Domain Services
- Almacenes de Azure Backup
- Puertas de enlace de Azure App Service

Las máquinas virtuales tienen sus propias limitaciones que debe tener en cuenta:

- Si quiere trasladar una máquina virtual, todos sus dependientes deben trasladarse con ella.
- No se pueden trasladar máquinas virtuales con certificados en Azure Key Vault de una suscripción a otra.
- No se pueden migrar conjuntos de escalado de máquinas virtuales con equilibradores de carga estándar o IP pública estándar.
- No se pueden trasladar los discos administrados que se encuentran en zonas de disponibilidad a una suscripción diferente.

## _Validar recursos en Azure_
Antes de intentar mover un recurso, puede probar si se hará correctamente. por medio de la operacion `validate move` desde la API de REST de Azure. Esto se hace por Azure PowerShell o la CLI de Azure. Azure Portal realiza una validación automática antes de permitirle trasladar recursos.

Para llamar por RSEST mediante Azure CLI:
```
az rest --method post --uri <enter the correct REST operation URI here>
```

Ejemplo:
```
az rest --method post /
   --uri https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/<your-source-group>/validateMoveResources?api-version=2019-05-10 /
   --body "{\"resources\": [\"<your-resource-id-1>\", \"<your-resource-id-2>\", \"<your-resource-id-3>\"], \"targetResourceGroup\": \"/subscriptions/<your-subscription-id>/resourceGroups/<your-target-group>\"}"
```

Cuando se usa la CLI de Azure para llamar a una operación de la API de REST de Azure, no es necesario proporcionar un identificador de suscripción o un token de acceso. La CLI incluye estos valores automáticamente.