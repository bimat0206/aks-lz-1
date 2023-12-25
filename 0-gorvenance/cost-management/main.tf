data "azurerm_subscription" "current" {}
locals {
  current_time = timestamp()
  future_time  = timeadd(timestamp(), "24h")
  start_time = timeadd(timestamp(), "15m")
  stop_time = timeadd("2024-01-01T00:00:00Z", "720h")
}
resource "azurerm_cost_anomaly_alert" "example" {
  name            = "cost-anomaly-alert"
  display_name    = "cost-anomaly-alert"
  email_subject   = "Halliburton_cost_anomaly_alert "
  email_addresses = ["manhht6@fpt.com"]
                lifecycle {
    ignore_changes = [email_subject,name,display_name,email_addresses]
  }
}

#setting budgets and alerts at different scopes to proactively monitor the cost.



resource "azurerm_consumption_budget_subscription" "example" {
  name            = "budget-alert"
  subscription_id = data.azurerm_subscription.current.id

  amount     = 3000
  time_grain = "Monthly"

  time_period {
    start_date = "2024-01-01T00:00:00Z"
    end_date   = local.stop_time
  }
  notification {
    enabled        = true
    threshold      = 80.0
    operator       = "EqualTo"
    threshold_type = "Actual"

    contact_emails = [
"manhht6@fpt.com"
    ]
  }
}