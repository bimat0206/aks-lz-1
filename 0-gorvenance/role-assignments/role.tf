
data "azurerm_subscription" "primary" {
    subscription_id = var.subscription_id
}



resource "azurerm_role_assignment" "multiple_assignments" {
 count= length(var.role_assignment)
  role_definition_name = var.role_assignment[count.index].role_name
  scope                = data.azurerm_subscription.primary.id
  principal_id = var.role_assignment[count.index].principal_object_id
}


