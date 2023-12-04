resource "azurerm_container_registry" "acr" {
    count = length(var.container_registry_name)
  name                = "${var.container_registry_name[count.index]}${random_string.random_suffix.result}"
  resource_group_name = var.resource_group_name 
  location            = var.resource_group_location
  sku                 = "Premium"
  tags     = var.resource_labels

  admin_enabled       = false
  anonymous_pull_enabled = true
  public_network_access_enabled = true

}
resource "random_string" "random_suffix" {
  length  = 4
  special = false
  upper   = false

}