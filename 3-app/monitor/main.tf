resource "azurerm_monitor_workspace" "example" {
  name                = "example-mamw"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
tags     = var.resource_labels
}

