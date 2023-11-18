output "virtual_network_ids" {
  description = "IDs of the created virtual networks"
  value = values({
    for network_key, network in azurerm_virtual_network.example :
    network_key => network.id
  })
}

output "virtual_network_names" {
  description = "Names of the created virtual networks"
  value = values({
    for network_key, network in azurerm_virtual_network.example :
    network_key => network.name
  })
}

output "virtual_network_resource_group" {
  description = "resource_group of the created virtual networks"
  value = azurerm_resource_group.example.name
}

/*
output "virtual_network_ids" {
  value = [for vnet in azurerm_virtual_network.example : vnet.id]
}

output "virtual_network_names" {
  value = [for vnet in azurerm_virtual_network.example : vnet.name]
}
*/

output "hub_resource_group_name" {
  value = azurerm_resource_group.example[*].name
}
output "hub_resource_group_id" {
  value = azurerm_resource_group.example[*].id
}
output "hub_resource_group_location" {
  value = azurerm_resource_group.example[*].location
}
