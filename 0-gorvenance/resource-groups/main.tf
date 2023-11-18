resource "azurerm_resource_group" "example" {
  for_each = var.resource_groups

  name     = "${var.prefix}-${each.key}-rg"
  location = each.value
  tags = var.resource_labels
}
