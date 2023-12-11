
locals {
  current_time = timestamp()
  future_time  = timeadd(timestamp(), "24h")
  start_time = timeadd(timestamp(), "15m")
  stop_time = timeadd(timestamp(), "25m")
}

resource "azurerm_automation_account" "example" {
  name                = "${var.prefix}-1-automation-acc"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
  sku_name            = "Basic"

tags     = var.resource_labels
}
