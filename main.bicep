// Specify the target scope
targetScope = 'subscription'

param date string = utcNow(format('yyyy-MM-dd'))
param deployEnvironment string = 'dev'

// Parameters
param location string = 'westeurope'
param resourceGroupName string = 'dev-rg-bicep'
param appServicePlanName string = 'dev-bicep-appServicePlan'
param appServiceName string = 'dev-bicep-appService'
param keyVaultName string = 'dev-bicep-keyVault'
param sqlServerName string = 'dev-bicep-sqlServer'
param sqlDatabaseName string = 'dev-bicep-sqlDatabase'
param logicAppName string = 'dev-bicep-logicApp'
param apiUrl string = 'https://example.com/api'
param executingPrincipalObjectId string

param createAppService bool = true
param createKeyVault bool = true
param createSqlServer bool = true
param createSqlDatabase bool = true
param createLogicApp bool = true

param tags object ={
  environment: deployEnvironment
  project: 'bicep'
  'last-review': date
  repo: 'yourinfrarepo'
  author: 'ketan'
}

// Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Conditional deployments for resources within the resource group
module appServicePlanModule 'appServicePlan.bicep' = if (createAppService)  {
  name: 'appServicePlanModule'
  scope: resourceGroup
  params: {
    location: location
    appServicePlanName: appServicePlanName
    tags: tags
  }
}

module appServiceModule 'appService.bicep' = if (createAppService) {
  name: 'appServiceModule'
  scope: resourceGroup
  params: {
    location: location
    appServiceName: appServiceName
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
    tags: tags
  }
}

module keyVaultModule 'keyVault.bicep' = if (createKeyVault) {
  name: 'keyVaultModule'
  scope: resourceGroup
  params: {
    location: location
    keyVaultName: keyVaultName
    appServicePrincipalId: appServiceModule.outputs.appServicePrincipalId
    executingPrincipalObjectId: executingPrincipalObjectId
    tags: tags
  }
}

module sqlServerModule 'sqlServer.bicep' = if (createSqlServer) {
  name: 'sqlServerModule'
  scope: resourceGroup
  params: {
    location: location
    sqlServerName: sqlServerName
    tags: tags
  }
}

module sqlDatabaseModule 'sqlDatabase.bicep' = if (createSqlDatabase) {
  name: 'sqlDatabaseModule'
  scope: resourceGroup
  params: {
    location: location
    sqlServerName: sqlServerName
    sqlDatabaseName: sqlDatabaseName
    tags: tags
  }
}

module logicAppModule 'logicApp.bicep' = if (createLogicApp) {
  name: 'logicAppModule'
  scope: resourceGroup
  params: {
    location: location
    logicAppName: logicAppName
    apiUrl: apiUrl
    tags: tags 
  }
}


  // Save the generated password in Key Vault
module keyVaultSecretModule 'keyVaultSecret.bicep' = if (createSqlDatabase) {
  name: 'keyVaultSecretModule'
  scope: resourceGroup
  params: {
    keyVaultName: keyVaultName
    sqlAdminPassword: sqlServerModule.outputs.adminPassword
  }
}

