resource "azurerm_firewall_policy" "example" {
  name                = "policy1"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags = var.resource_labels
}

/*
resource "azurerm_firewall" "example" {
  count = length(var.firewalls)

  name                = var.firewalls[count.index].name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags = var.resource_labels


  sku_name            = "AZFW_Hub"
  sku_tier            = "Standard"
  firewall_policy_id = azurerm_firewall_policy.example.id
  
  
  dynamic "ip_configuration" {
    for_each = var.firewalls[count.index].name

    content {
      name = var.firewalls[count.index].name
      subnet_id = var.firewalls[count.index].subnet_id
      public_ip_address_id = var.firewalls[count.index].public_ip_address_id
    }
  }
}
*/
resource "azurerm_firewall" "example" {
  for_each = var.firewalls

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags = var.resource_labels

  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.example.id
  
  dynamic "ip_configuration" {
    for_each = var.firewalls # You can use any value here as it's just a placeholder for the dynamic block.

    content {
      name               = each.value.name
      subnet_id          = each.value.subnet_id
      public_ip_address_id = each.value.public_ip_address_id
    }
  }
      lifecycle {
    ignore_changes = [ip_configuration,name]
  }
}
