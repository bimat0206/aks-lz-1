
output "container_resource_group_name" {
  value = azurerm_resource_group.example["container"].name
}
output "container_resource_group_id" {
  value = azurerm_resource_group.example["container"].id
}
output "container_resource_group_location" {
  value = azurerm_resource_group.example["container"].location
}