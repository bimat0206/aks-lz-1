

resource "azurerm_network_manager" "example" {

  name                = "${var.prefix}-network-manager-nm"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  scope {
    subscription_ids = [var.subscription_id]
  }
  scope_accesses = ["Connectivity", "SecurityAdmin"]
  description    = "Network manager"
tags = var.resource_labels
}

resource "azurerm_network_manager_network_group" "spoke" {
  name               = "${var.prefix}-spoke-group-nm"
  network_manager_id = azurerm_network_manager.example.id
}

resource "azurerm_network_manager_network_group" "hub" {
  name               = "${var.prefix}-hub-group-nm"
  network_manager_id = azurerm_network_manager.example.id
}

resource "azurerm_network_manager_connectivity_configuration" "example" {
  name                  = "${var.prefix}-connectivity-conf-nm"
  network_manager_id    = azurerm_network_manager.example.id
  connectivity_topology = "HubAndSpoke"
  applies_to_group {
    #Enabling Direct connectivity creates an overlay of a connected group on top of your hub and spoke topology
    #Direct connectivity allows a spoke VNet to talk directly to other VNets in its spoke group, but not to VNets in other spokes.
    group_connectivity = "DirectlyConnected"
    global_mesh_enabled = true
    #use_hub_gateway = true
    network_group_id   = azurerm_network_manager_network_group.spoke.id
  }
  hub {
    resource_id   = var.hub_resource_id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_static_member" "hub" {
  name                      = "${var.prefix}-hub-group-nm"
  network_group_id          = azurerm_network_manager_network_group.hub.id
  target_virtual_network_id = var.target_virtual_network_id1

    lifecycle {
    ignore_changes = [name,network_group_id,target_virtual_network_id]
  }
}

resource "azurerm_network_manager_static_member" "spoke" {
  name                      = "${var.prefix}-spoke-group-nm"
  network_group_id          = azurerm_network_manager_network_group.spoke.id
  target_virtual_network_id = var.target_virtual_network_id2

    lifecycle {
    ignore_changes = [name,network_group_id,target_virtual_network_id]
  }
}
resource "azurerm_network_manager_deployment" "example" {
  network_manager_id = azurerm_network_manager.example.id
  location           = var.resource_group_location
  scope_access       = "Connectivity"
  configuration_ids  = [azurerm_network_manager_connectivity_configuration.example.id]

}