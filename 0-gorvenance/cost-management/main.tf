resource "azurerm_cost_anomaly_alert" "example" {
  name            = "cost-anomaly-alert"
  display_name    = "cost-anomaly-alert"
  email_subject   = "panasonic_cost_anomaly_alert "
  email_addresses = ["manhht6@fpt.com"]
                lifecycle {
    ignore_changes = [email_subject,name,display_name,email_addresses]
  }
}