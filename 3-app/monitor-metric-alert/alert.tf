/*
module "caf_monitor_metric_alert" {
  source  = "aztfmod/caf/azurerm//modules/monitoring/monitor_metric_alert"
  version = "5.7.7"
  # insert the 4 required variables here
  name = "${var.metric_alert["name"]}-alert"
  resource_group_name = var.resource_group_name

  settings{

  }
  scopes = var.metric_alert_scopes
  frequency = var.metric_alert["frequency"]
  severity = var.metric_alert["severity"]
  description = var.metric_alert["description"]
  criteria{
      metric_namespace = var.metric_alert["criteria_metric_namespace"]
      metric_name      = var.metric_alert["criteria_metric_name"]
      aggregation      = var.metric_alert["criteria_aggregation"]
      operator         = var.metric_alert["criteria_operator"]
      threshold        = var.metric_alert["criteria_threshold"]

      dimension{
     name     = var.metric_alert["dimension_name"]
          operator = var.metric_alert["dimension_operator"]
          values   = var.metric_alert["dimension_values"]
  }
  }
  


  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
  #tags     = var.resource_labels
}
*/

resource "azurerm_monitor_metric_alert" "example" {
  name = "${var.metric_alert["name"]}-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.metric_alert_scopes
  description         = var.metric_alert["description"]
tags     = var.resource_labels
  criteria {
      metric_namespace = var.metric_alert["criteria_metric_namespace"]
      metric_name      = var.metric_alert["criteria_metric_name"]
      aggregation      = var.metric_alert["criteria_aggregation"]
      operator         = var.metric_alert["criteria_operator"]
      threshold        = var.metric_alert["criteria_threshold"]

    dimension {
     name     = var.metric_alert["dimension_name"]
          operator = var.metric_alert["dimension_operator"]
          values   = [var.metric_alert["dimension_values"]]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}