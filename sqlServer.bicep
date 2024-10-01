// Parameters
param location string
param sqlServerName string
param tags object

var basePassword = uniqueString(resourceGroup().id)
var complexPassword = concat(basePassword, 'A1!', uniqueString('extraPart'))

// Ensure the password meets complexity requirements
var sqlAdminPassword = take(complexPassword, 16) // Adjust length as needed


// SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: sqlAdminPassword
  }
  tags: tags
}

output adminPassword string = sqlAdminPassword
