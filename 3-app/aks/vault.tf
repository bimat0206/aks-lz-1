# Create Azure Key Vault
resource "azurerm_key_vault" "aks_secrets" {
  name                = "aks-secrets-${var.resource_group_name}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}