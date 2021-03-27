#Login and set a suscription
az login
az account set --subscription "Azure for Students"

#Check resource group available in current subscription
az group list --output table

#Create a RG if needed
az group create `
    --name "psdemo-rg" `
    --location "eastus" 

# Creating Windows VM
az vm create `
    --resource-group "psdemo-rg" `
    --name "psdemo-win-cli" `
    --image "win2019datacenter" `
    --admin-username "demoadmin" `
    --admin-password "D3m0Admin@1122"

# Open RDP for remote access
az vm open-port `
    --resource-group "psdemo-rg" `
    --name "psdemo-win-cli" `
    --port "3389"

# Get IP address for remote access
az vm list-ip-addresses `
    --resource-group "psdemo-rg" `
    --name "psdemo-win-cli" `
    --output table
