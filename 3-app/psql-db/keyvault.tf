locals {
  psql_cred = {
    username             = "${random_string.administrator_login.result}",
    password             = "${random_password.master_password.result}",
    server_id          = "${azurerm_postgresql_flexible_server.example.id}",
    port= 5432
  }
}

data "azurerm_client_config" "current" {}

# Create Azure Key Vault
resource "azurerm_key_vault" "psql_vault" {
  name = "${var.psql_servers["server_name"]}-${random_string.db_name.result}-psql"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku_name            = "standard"
   tenant_id = data.azurerm_client_config.current.tenant_id
tags     = var.resource_labels
   access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

   key_permissions = [
      "Create",
      "Get",
      "List",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]
  

    storage_permissions = [
      "Get",
      "List",
    ]
  }

}

# Create Key Vault Secret for the Administrator Password
resource "azurerm_key_vault_secret" "psql_cred" {
  name = "${var.prefix}-${var.psql_servers["server_name"]}-${random_string.db_name.result}-psql-secret"
  value = jsonencode(local.psql_cred)
  key_vault_id = azurerm_key_vault.psql_vault.id
}
