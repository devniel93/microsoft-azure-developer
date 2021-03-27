# Creating Linux VM
## generate-ssh-keys: generate SSH public and private key files. The keys are stored in the ~/. ssh directory.
az vm create `
    --resource-group "psdemo-rg" `
    --name "psdemo-linux-cli" `
    --image "UbuntuLTS" `
    --admin-username "demoadmin" `
    --authentication-type "ssh" `
    --generate-ssh-keys 
    #--ssh-key-value ~/.ssh/id_rsa.pub

# Open SSH for remote access
az vm open-port `
    --resource-group "psdemo-rg" `
    --name "psdemo-linux-cli" `
    --port "22"

# Get IP address for remote access
az vm list-ip-addresses `
    --resource-group "psdemo-rg" `
    --name "psdemo-linux-cli" `
    --output table

# Log into the Linux VM over SSH
ssh demoadmin@13.68.172.29

# Clean up the resources in this demo
az group delete --name "psdemo-rg"