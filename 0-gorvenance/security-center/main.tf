data "azurerm_subscription" "primary" {
    subscription_id = var.subscription_id
}


resource "azurerm_log_analytics_workspace" "example" {
  name                = "${var.prefix}-security-center-log"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
              lifecycle {
    ignore_changes = [name]
  }
}
resource "azurerm_security_center_workspace" "example" {
  scope        = data.azurerm_subscription.primary.id
  workspace_id = azurerm_log_analytics_workspace.example.id
            lifecycle {
    ignore_changes = [workspace_id]
  }
}
resource "azurerm_security_center_auto_provisioning" "example" {
  auto_provision = "On"
          lifecycle {
    ignore_changes = [auto_provision]
  }
}
resource "azurerm_security_center_subscription_pricing" "example" {
  tier          = "Standard"
  resource_type = "Containers"
}
resource "azurerm_security_center_setting" "example" {
  setting_name = "SENTINEL"
  enabled      = true
        lifecycle {
    ignore_changes = [setting_name,enabled]
  }
}
resource "azurerm_security_center_subscription_pricing" "example1" {
  tier          = "Standard"
  resource_type = "CloudPosture"

  extension {
    name = "ContainerRegistriesVulnerabilityAssessments"
  }

  extension {
    name = "AgentlessVmScanning"
    additional_extension_properties = {
      ExclusionTags = "[]"
    }
  }

  extension {
    name = "AgentlessDiscoveryForKubernetes"
  }

  extension {
    name = "SensitiveDataDiscovery"
  }
}