data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}
data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_mssql_server" "example" {
  for_each = var.mssql_servers

  name ="${var.prefix}-${each.key}-sql-server"
  resource_group_name = var.resource_group_name
  location = data.azurerm_resource_group.example.location

  version = "12.0"
  administrator_login = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  tags     = var.resource_labels
}

resource "azurerm_mssql_database" "example" {
  for_each = var.databases

  name = "${var.prefix}-${each.key}-sql-db"
  server_id = azurerm_mssql_server.example[each.value.server_name].id
  max_size_gb = "100"
  tags     = var.resource_labels
}
resource "azurerm_mssql_virtual_network_rule" "example" {
    for_each = var.mssql_servers
  name      = "${var.prefix}-${each.key}-sql-network-rule"
  server_id = azurerm_mssql_server.example[each.value.server_name].id
  subnet_id = data.azurerm_subnet.example.id
}