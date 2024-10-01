// Parameters
param location string
param appServicePlanName string
param tags object

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  tags: tags
}

output appServicePlanId string = appServicePlan.id
