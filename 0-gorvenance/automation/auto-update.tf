
resource "azurerm_log_analytics_workspace" "example" {
  name                = "${var.prefix}-update-vm-log-workspace"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}



resource "azurerm_log_analytics_solution" "example" {
  solution_name         = "${var.prefix}-update-vm-log-workspace"
  location       = var.resource_group_location
  resource_group_name = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.example.id
  workspace_name        = azurerm_log_analytics_workspace.example.name

  plan {
    publisher = "Microsoft"
    product   = "Updates"
  }
}


resource "azurerm_log_analytics_linked_service" "example" {
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.example.id
  read_access_id      = azurerm_automation_account.example.id
}


resource "azurerm_automation_software_update_configuration" "example" {
  name                = "${var.prefix}-update-vm-config"
  automation_account_id = azurerm_automation_account.example.id
  
    windows {
    classifications_included = ["Updates"]
    reboot                   = "IfRequired"
  }

target {
    azure_query {
      scope =  ["/subscriptions/${var.subscription_id}"]
    }
  }
  schedule {
    is_enabled  = true
    frequency   = "Hour"
    description = "Windows Definition Updates"
    interval    = 2
    time_zone   = "Asia/Bangkok"
    start_time  = local.future_time

  }
        lifecycle {
    ignore_changes = [schedule]
  }
  #log_analytics_solution_ids = [azurerm_log_analytics_solution.example.id, azurerm_log_analytics_solution.example2.id]
}
