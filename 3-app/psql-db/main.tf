resource "random_string" "db_name" {
  length  = 4
  special = false
  upper   = false

}
resource "random_string" "administrator_login" {
  length  = 6
  special = false
  upper   = false

}
resource "random_password" "master_password" {
  length  = 10
  special = false
}

resource "azurerm_postgresql_flexible_server" "example" {

  name                   = "${var.prefix}-${var.psql_servers["server_name"]}-${random_string.db_name.result}-psql"
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  version                = var.psql_servers["version"]
  administrator_login    = random_string.administrator_login.result
  administrator_password = random_password.master_password.result
  storage_mb             = var.psql_servers["storage_mb"]
  sku_name               = var.psql_servers["sku_name"]
  auto_grow_enabled = true
  tags     = var.resource_labels

}

resource "azurerm_postgresql_flexible_server_database" "example" {
  name      = "sample-psql-db"
  server_id = azurerm_postgresql_flexible_server.example.id
  collation = "en_US.utf8"
  charset   = "utf8"
  
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "public-access" {
  name             = "${var.prefix}-${var.psql_servers["server_name"]}-${random_string.db_name.result}-psql-public-access-fw-rule"
  server_id        = azurerm_postgresql_flexible_server.example.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}