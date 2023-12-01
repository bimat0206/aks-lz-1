resource "random_string" "random_suffix" {
  length  = 4
  special = false
  upper   = false

}

module "vgw1" {
  source  = "Azure/avm-ptn-vnetgateway/azurerm"
  version = "0.1.0" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  location                            = var.resource_group_location
  name                                = "${var.prefix}-${random_string.random_suffix.result}-vgw"
  sku                                 = "VpnGw2"
  subnet_address_prefix               = var.virtual_network_subnet_address_prefix
  type                                = "Vpn"
  virtual_network_name                = var.virtual_network_name
  vpn_active_active_enabled = true
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  tags = var.resource_labels
}