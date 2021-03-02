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

## _Descripción de traslados de recursos_
Cuando se inicia un proceso de trasaldo, se bloquea el RG que contiene los recursos y el RG destino, es decir no se pueden actualizar o eliminar en los RG hasta que termine el traslado. Los recursos que se trasladan no cambian de ubicacion o region.

### Traslado de recursos entre suscripciones
Los recursos se pueden trasladar entre suscripciones o entre grupos de recursos dentro de la misma suscripción. 

- Traslade los recursos dependientes a un grupo de recursos con el recurso.
- Traslade el recurso y los recursos dependientes juntos desde la suscripción de origen a la de destino.
- Opcionalmente, se puede redistribuir los recursos dependientes a distintos grupos de recursos dentro de la suscripción de destino.

## _Cómo trasladar recursos_

### Movimiento de recursos mediante la CLI de Azure
1. Crear un RG
```
az group create --name <destination resource group name> --location <location name>
```

2.  Obtener el recurso
```
yourResource=$(az resource show --resource-group <resource group name> --name <resource name> --resource-type <resource type> --query id --output tsv)
```

3. Trasladar el recurso a otro RG 
```
az resource move --destination-group <destination resource group name> --ids $yourResource
```

4. Listar todos los recursos del RG para que comprobar el traslado
```
az resource list --resource-group <destination resource group name> --query [].type --output tsv | uniq
```

### Trasladar recursos mediante Azure PowerShell
1. Crear un RG
```
New-AzResourceGroup -Name <destination resource group name> -Location <location name>
```

2.  Obtener el recurso
```
$yourResource = Get-AzResource -ResourceGroupName <resource group name> -ResourceName <resource name>
```

3. Trasladar el recurso a otro RG 
```
Move-AzResource -DestinationResourceGroupName <destination resource group name> -ResourceId $yourResource.ResourceId
```

4. Listar todos los recursos del RG para que comprobar el traslado
```
Get-AzResource -ResourceGroupName <destination resource group name> | ft
```