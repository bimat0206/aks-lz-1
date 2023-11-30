resource "azurerm_virtual_wan" "example" {
  name                = "${var.prefix}-${var.virtual_wan_name}-virtualwan"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags     = var.resource_labels
}

resource "azurerm_virtual_hub" "example" {
  name                = "${var.prefix}-${var.virtual_hub_name}-virtualhub"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  virtual_wan_id      = azurerm_virtual_wan.example.id
  address_prefix      = var.virtual_hub_address_prefix
  tags     = var.resource_labels
}

