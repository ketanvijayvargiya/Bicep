// Parameters
param location string
param keyVaultName string
param appServicePrincipalId string
param tags object
param executingPrincipalObjectId string

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: executingPrincipalObjectId
        permissions: {
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'         
          ]
        }
      }
      {
        tenantId: subscription().tenantId
        objectId: appServicePrincipalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
  }
  tags: tags
}
