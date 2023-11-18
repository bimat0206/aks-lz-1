
data "azurerm_subscription" "current" {}

# Create Azure Policy definitions and assignments

locals {
  policy_rules = jsondecode(file("${path.module}/conf/policies.json"))
}

resource "azurerm_policy_definition" "policy_definitions" {
  for_each = { for rule in local.policy_rules.policy_rules : rule.name => rule }

  name         = each.value.name
  display_name = "${var.prefix}-${each.value.displayName}-policy-rule"
  description  = each.value.description
  policy_type  = "Custom"
  mode         = "All"

  policy_rule = jsonencode(each.value.policyRule)
  parameters  = jsonencode(each.value.parameters)
      lifecycle {
    ignore_changes = [display_name,name,policy_rule,parameters]
  }
}

resource "azurerm_subscription_policy_assignment" "policy_assignments" {
  for_each = { for rule in local.policy_rules.policy_rules : rule.name => rule }

  name                 = each.value.name
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.policy_definitions[each.key].id
  enforce              = true
  display_name         = "${var.prefix}-${each.value.displayName}-policy-assignment"
  parameters           = jsonencode(each.value.parameters)

    lifecycle {
    ignore_changes = [name,display_name,parameters]
  }
}



