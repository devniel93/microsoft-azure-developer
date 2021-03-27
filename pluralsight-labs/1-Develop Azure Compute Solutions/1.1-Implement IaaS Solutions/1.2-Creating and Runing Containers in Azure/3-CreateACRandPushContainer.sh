az login
az account set --subscription "Azure for Students"

#Step 1 - Create an Azure Container Registry
#SKUs include Basic, Standard and Premium (speed, replication, adv security features)
#https://docs.microsoft.com/en-us/azure/container-registry/container-registry-skus#sku-features-and-limits
#ACRN_NAME NEEDS TO BE GLOBALLY unique inside of Azure
#https://docs.microsoft.com/en-us/rest/api/containerregistry/registries/checknameavailability#containerregistryresourcetype
# REQUEST EXAMPLE:
# { "name": "mypsdemoacr", "type": "Microsoft.ContainerRegistry/registries" }
ACR_NAME='mypsdemoacr'  
az acr create \
    --resource-group psdemo-rg \
    --name $ACR_NAME \
    --sku Standard

#Step 2 - Log into ACR to push containers...this will use our current azure cli login context
az acr login --name $ACR_NAME

#Step 3 - Get the loginServer which is used in the image tag
ACR_LOGINSERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
echo $ACR_LOGINSERVER

#Step 4 - Tag the container image using the login server name.
#[loginUrl]/[repository:][tag]
docker tag webappimage:v1 $ACR_LOGINSERVER/webappimage:v1
docker image ls $ACR_LOGINSERVER/webappimage:v1
docker image ls

#Step 5 - Push image to Azure Container Registry
docker push $ACR_LOGINSERVER/webappimage:v1

#Step 6 - Get a listing of the repositories and images/tags in our Azure Container Registry
az acr repository list --name $ACR_NAME --output table
az acr repository show-tags --name $ACR_NAME --repository webappimage --output table


####
#We don't have to build locally then push, we can build in ACR with Tasks.
####

#Step 1 - use ACR build to build our image in azure and then push that into ACR
az acr build --image "webappimage:v1-acr-task" --registry $ACR_NAME .

#Both images are in there now, the one we built locally and the one build with ACR tasks
az acr repository show-tags --name $ACR_NAME --repository webappimage --output table
