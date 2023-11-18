output "spoke1_nsg_id" {
  value = azurerm_network_security_group.example["rule1-nsg"].id
}
output "hub_nsg_id" {
  value = azurerm_network_security_group.example["rule2-nsg"].id
}
