resource "azurerm_monitor_action_group" "main" {
  name                = "${var.prefix}-${var.action_group["name"]}-action-group"
  resource_group_name = var.resource_group_name
  short_name          = var.action_group["short_name"]
enabled =true
  email_receiver {
    name                    = "sendtodevops"
    email_address           = var.action_group["email_address"]
    use_common_alert_schema = true
  }

tags     = var.resource_labels
}