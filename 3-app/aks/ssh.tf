
resource "random_string" "ssh_key_name" {
  length  = 4
  special = false
  upper   = false

}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "${var.prefix}-ssh-${random_string.ssh_key_name.id}"
  location  = var.resource_group_location
  parent_id = azurerm_resource_group.rg.id
}

output "key_data" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}
# Create Azure Key Vault
resource "azurerm_key_vault" "ssh" {
  name                = "${var.prefix}-ssh-${random_string.ssh_key_name.id}-vault"
  location            = var.resource_group_location
  sku_name                   = "premium"
  resource_group_name = var.resource_group_name
  tags     = var.resource_labels
  tenant_id           = data.azurerm_client_config.current.tenant_id
}
resource "azurerm_key_vault_secret" "ssh-publickey" {
  name         = "${var.prefix}-ssh-publickey-${random_string.ssh_key_name.id}-secret"
  value        = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  key_vault_id = azurerm_key_vault.example.id
  tags     = var.resource_labels
}