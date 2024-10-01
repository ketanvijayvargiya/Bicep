// Parameters
param location string
param appServiceName string
param appServicePlanId string
param tags object

// App Service
resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlanId
  }
  identity: {
    type: 'SystemAssigned'
  }
  tags: tags
}

output appServicePrincipalId string = appService.identity.principalId
