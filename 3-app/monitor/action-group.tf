
data "azurerm_client_config" "current" {
}

resource "azurerm_log_analytics_workspace" "monitor-aks" {
  name                = "workspace-01"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_monitor_action_group" "example" {
  name                = "voting-app-CriticalAlertsAction"
  resource_group_name = var.resource_group_name
  short_name          = "p0action"
  enabled = true


  email_receiver {
    name                    = "sendtodevops"
    email_address           = "manhht6@fpt.com"
    use_common_alert_schema = true
  }

}