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

---

## _¿Qué son los cmdlets de PowerShell?_
Un comando de PowerShell se denomina cmdlet, es un comando que manipula una sola caracteristica. Los cmdlets siguen una convención de nomenclatura de verbo-sustantivo, por ejemplo, Get-Process, Format-Table y Start-Service.


## _¿Qué son los módulos de PowerShell?_
Los cmdlets se suministran en módulos. Un módulo de PowerShell es un archivo DLL que incluye el código necesario para procesar todos los cmdlets disponibles. Se puede obtener los modulos disponibles ejecutando `Get-Module`

## _¿Qué es un módulo Az?_
Az es el nombre formal del módulo de Azure PowerShell que contiene cmdlets para trabajar con las características de Azure. 
* El módulo Az incluye compatibilidad con versiones anteriores del módulo AzureRM. Por lo tanto, el formato de cmdlet -AzureRM funcionará, pero deberá realizar la transición al módulo Az.

### Instalación del módulo Az
1. Ejecutar como admin Windows Powershell
2. Ejecutar el comando
```
Install-Module -Name Az -AllowClobber -SkipPublisherCheck
```

3. Si ocurre error en la ejecucion por direcion "restringida", ejecutar 
```
Set-ExecutionPolicy RemoteSigned
```

4. Si recibe un mensaje que ya existe una version instalada de Azure, ejecutar actualizacion
```
Update-Module -Name Az
```

5. Conectarse a la cuenta de Azure
```
Connect-AzAccount
```

6. Para obtener la suscripcion activa
```
Get-AzContext
```

6. Para setear la suscripcion de Azure
```
Select-AzSubscription -SubscriptionId '53dde41e-916f-49f8-8108-558036f826ae'
```

7. Para obtener una lista de todos los grupos de recursos de la suscripción activa
```
Get-AzResourceGroup | Format-Table
```

8. Para crear un Resource Group
```
New-AzResourceGroup -Name <name> -Location <location>
```

9. Para crear una VM
```
New-AzVm 
       -ResourceGroupName <resource group name> 
       -Name <machine name> 
       -Credential <credentials object> 
       -Location <location> 
       -Image <image name>
```

10. Para asignar variales y tomar dicho objeto para hacer otras acciones
```
$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm
```

11. Para crear una Vm abriendo puerto 22 para acceso SSH
```
New-AzVm -ResourceGroupName learn-43199bc4-dfcf-4174-b484-86611eaa7318 -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22
```
devniel93
Sistem123@$12345

12. Para acceder a las propiedades del hardware
```
$vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName learn-43199bc4-dfcf-4174-b484-86611eaa7318)
$vm.HardwareProfile
```

13. Para obtener información sobre uno de los discos
```
$vm.StorageProfile.OsDisk
```

14. Para obtener IP publica
```
$vm | Get-AzPublicIpAddress
```

15. Para conectarse por SSH 
```
ssh devniel93@52.170.0.205
```

16. Para eliminar una VM
Primero, cerrar
```
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
```

Luego eliminar (Esto solo eliminara la VM)
```
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
```

Para comprobar los recursos 
```
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft
```

17. Eliminar interfaz de red
```
$vm | Remove-AzNetworkInterface –Force
```

18. Eliminar los discos administrados del SO y el storage account
```
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
```

19. Eliminar la VNet
```
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
```

20. Eliminar el NSG
```
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
```

21. Eliminar la IP Publica
```
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
```

--- 

## _¿Qué es un script de PowerShell?_
Es un archivo de texto que contiene comandos y construcciones de control. Los comandos son invocaciones de los cmdlets. Las construcciones de control son características de programación como bucles, variables, parámetros, comentarios, etc., proporcionadas por PowerShell. Tienen la extensión de archivo .ps1. 

## _Creación y guardado de scripts en Azure PowerShell_

1. Crear un archivo `touch "./ConferenceDailyReset.ps1"`
2. Editar el archivo 
```
param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}
```

3. Ejecutar el script
```
.\ConferenceDailyReset.ps1 learn-43199bc4-dfcf-4174-b484-86611eaa7318
```

4. Comprobar los recursos
```
Get-AzResource -ResourceType Microsoft.Compute/virtualMachines
```