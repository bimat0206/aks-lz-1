
data "azurerm_policy_definition_built_in" "p1" {
  display_name = "[Preview]: Machines should have ports closed that might expose attack vectors"
}


resource "azurerm_subscription_policy_assignment" "p1" {

  name                 = "${var.prefix}-vm-ports-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition_built_in.p1.id
  description = "Azure's Terms Of Use prohibit the use of Azure services in ways that could damage, disable, overburden, or impair any Microsoft server, or the network. The exposed ports identified by this recommendation need to be closed for your continued security. For each identified port, the recommendation also provides an explanation of the potential threat."
  enforce              = true
  location = "Southeast Asia"
  display_name         = "${var.prefix}-vm-ports-policy-assignment"
identity {
  type = "SystemAssigned"
}
    lifecycle {
    ignore_changes = [name,display_name,parameters]
  }
}
data "azurerm_policy_definition_built_in" "p2" {
  display_name = "Azure Key Vault should disable public network access"
}


resource "azurerm_subscription_policy_assignment" "p2" {

  name                 = "${var.prefix}-keyvault-disable-public-network-access"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition_built_in.p2.id
  description = "Disable public network access for your key vault so that it's not accessible over the public internet. This can reduce data leakage risks. Learn more at: https://aka.ms/akvprivatelink."
  enforce              = true
  location = "Southeast Asia"
  display_name         = "${var.prefix}-keyvault-disable-public-network-access"
identity {
  type = "SystemAssigned"
}
    lifecycle {
    ignore_changes = [name,display_name,parameters]
  }
}

#Inherit a tag from the resource group
data "azurerm_policy_definition_built_in" "p3" {
  display_name = "Inherit a tag from the resource group"
}


resource "azurerm_subscription_policy_assignment" "p3" {

  name                 = "${var.prefix}-inherit-tag-rg-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition_built_in.p3.id
  description = "Adds or replaces the specified tag and value from the parent resource group when any resource is created or updated. Existing resources can be remediated by triggering a remediation task."
  enforce              = true
  location = "Southeast Asia"
  display_name         = "${var.prefix}-inherit-tag-rg-policy-assignment"
identity {
  type = "SystemAssigned"
}
  parameters = file("${path.module}/conf/p3.json")


lifecycle {
    ignore_changes = [name,display_name,parameters]
  }
}

#Require a tag on resources
data "azurerm_policy_definition_built_in" "p4" {
  display_name = "Require a tag on resources"
}


resource "azurerm_subscription_policy_assignment" "p4" {

  name                 = "${var.prefix}-require-tag-resource-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition_built_in.p4.id
  description = "Enforces existence of a tag. Does not apply to resource groups."
  enforce              = true
  location = "Southeast Asia"
  display_name         = "${var.prefix}-require-tag-resource-policy-assignment"
identity {
  type = "SystemAssigned"
}
  parameters = file("${path.module}/conf/p4.json")


lifecycle {
    ignore_changes = [name,display_name,parameters]
  }
}
