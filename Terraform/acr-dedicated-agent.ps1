# Get the subnet ID
$subnetId=$(az network vnet subnet show `
        --resource-group rg-pvaks-cac `
        --vnet-name vnet-hub `
        --name snet-global `
        --query id --output tsv)

az acr agentpool create `
    --registry acrpvakscac `
    --name myagentpool `
    --tier S1 `
    --subnet-id $subnetId