
resource "azurerm_public_ip" "example" {
  count               = length(var.public_ips)
  name                =  "${var.prefix}-${var.public_ips[count.index].name}-ip"
  location            = var.location
  sku = "Standard"
  resource_group_name = var.public_ips[count.index].resource_group_name
  allocation_method   = var.public_ips[count.index].allocation_method
  tags     = var.resource_labels
}
