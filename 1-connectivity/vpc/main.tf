
resource "azurerm_resource_group" "example" {

  name     = "${var.prefix}-${var.resource_group_name}-rg"
  location = var.vnet_location
  tags     = var.resource_labels
}

   
resource "azurerm_virtual_network" "example" {
  for_each = var.networks

  name                = "${var.prefix}-${each.value.name}-vt"
  address_space       = each.value.address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "subnet" {
    for_each = var.networks[each.key].subnets

    content {
      name           = "${subnet.value.name}"
      address_prefix = subnet.value.address_prefix
      # You can also include "security_group" here if needed.
      #security_group = azurerm_network_security_group.example[each.key].id
    }
  }
}


