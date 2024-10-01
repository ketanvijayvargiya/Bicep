// Parameters
param keyVaultName string
@secure()
param sqlAdminPassword string

// Save the generated password in Key Vault
resource sqlAdminPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' = {
  name: '${keyVaultName}/sqlAdminPassword'
  properties: {
    value: sqlAdminPassword
  }
}
