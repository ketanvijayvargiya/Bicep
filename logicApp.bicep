param logicAppName string
param location string
param apiUrl string
param tags object

var workflowSchema = 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    definition: {
      '$schema': workflowSchema
      contentVersion: '1.0.0.0'
      parameters: {
        apiUrl: {
            type: 'string'
            defaultValue: apiUrl
        }
      }
      triggers: {
        recurrence: {
          type: 'recurrence'
          recurrence: {
            frequency: 'Minute'
            interval: '3'
          }
        }
      }
      actions: {
        callBot: {
          type: 'http'
          inputs: {
            method: 'GET'
            uri: apiUrl
          }
          runAfter: {}
        }
      }
    }
  }
  tags: tags
}
