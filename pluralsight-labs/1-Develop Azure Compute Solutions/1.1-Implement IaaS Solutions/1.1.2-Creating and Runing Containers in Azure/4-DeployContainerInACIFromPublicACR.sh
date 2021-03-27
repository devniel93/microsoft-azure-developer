az login
az account set --subscription "Azure for Students"

#Demo 0 - Deploy a container from a public registry.
az container create \
    --resource-group psdemo-rg \
    --name psdemo-hello-world-cli \
    --dns-name-label psdemo-hello-world-cli \
    --image mcr.microsoft.com/azuredocs/aci-helloworld \
    --ports 80

#Show the container info
az container show --resource-group 'psdemo-rg' --name 'psdemo-hello-world-cli' 

#Retrieve the URL, the format is [name].[region].azurecontainer.io
URL=$(az container show --resource-group 'psdemo-rg' --name 'psdemo-hello-world-cli' --query ipAddress.fqdn | tr -d '"') 
echo "http://$URL"