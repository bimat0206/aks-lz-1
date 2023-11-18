
output "recovery_resource_group_name" {
  value = azurerm_resource_group.example["recovery-center"].name
}
output "recovery_resource_group_id" {
  value = azurerm_resource_group.example["recovery-center"].id
}
output "recovery_resource_group_location" {
  value = azurerm_resource_group.example["recovery-center"].location
}
output "gorvernace_resource_group_name" {
  value = azurerm_resource_group.example["gorvernace"].name
}
output "gorvernace_resource_group_id" {
  value = azurerm_resource_group.example["gorvernace"].id
}
output "gorvernace_resource_group_location" {
  value = azurerm_resource_group.example["gorvernace"].location
}