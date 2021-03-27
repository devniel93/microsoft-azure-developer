# Run PowerShell as admin and run (only first time)
Install-Module Az

#Login to authenticate the session
Connect-AzAccount -SubscriptionName 'Azure for Students'

#Ensure point at the correct subscription
Set-AzContext -SubscriptionName 'Azure for Students'

#Create a Resource Group
New-AzResourceGroup -Name "psdemo-rg" -Location "eastus"

#Create a credential to use in the VM creation
$username = 'demoadmin'
$password = ConvertTo-SecureString 'D3m0Admin@1122' -AsPlainText -Force
$WindowsCred = New-Object System.Management.Automation.PSCredential ($username, $password)

#Create Windows VM (can be used for both Windows and Linux by specifying the correct image)
New-AzVM `
    -ResourceGroupName 'psdemo-rg' `
    -Name 'psdemo-win-az' `
    -Image 'Win2019Datacenter' `
    -Credential $WindowsCred `
    -OpenPorts 3389

#Get the public IP Address 
Get-AzPublicIpAddress `
    -ResourceGroupName 'psdemo-rg' `
    -Name 'psdemo-win-az' | Select-Object IpAddress
#52.188.208.70

#Clean up after this demo
Remove-AzResourceGroup -Name 'psdemo-rg'



