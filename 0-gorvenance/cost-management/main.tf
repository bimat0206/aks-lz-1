data "azurerm_subscription" "current" {}
locals {
  current_time = timestamp()
  future_time  = timeadd(timestamp(), "24h")
  start_of_month = formatdate("2006-01-02T15:04:05Z", timestamp() - (day(timestamp()) - 1) * 86400)
  start_time = timeadd(timestamp(), "15m")
  stop_time = timeadd(local.start_of_month, "720h")
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
    start_date = local.start_of_month
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