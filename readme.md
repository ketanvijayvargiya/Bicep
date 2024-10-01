# Azure group Deployment

This Bicep template creates azure resource group and with service

## Prerequisites

- Azure CLI installed
- Logged in to Azure CLI (`az login`)


## Command 

To deploy the Bicep template, use the following command:

az deployment sub create --location westeurope  --template-file main.bicep --name deploymentName --subscription <subscriptionId>

az group delete --name dev-rg-bicep --subscription <subscriptionId> --yes --no-wait




