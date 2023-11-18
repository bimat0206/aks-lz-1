
output "network_resource_group_name" {
  value = azurerm_resource_group.example["network"].name
}
output "network_resource_group_id" {
  value = azurerm_resource_group.example["network"].id
}
output "network_resource_group_location" {
  value = azurerm_resource_group.example["network"].location
}