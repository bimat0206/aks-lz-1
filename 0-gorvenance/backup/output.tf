# Output names of recovery vaults
output "vm_recovery_vault_name" {
  value = { for k, v in azurerm_recovery_services_vault.example : k => v.name if k == "virtual-machine" }
}

output "database_recovery_vault_name" {
  value = { for k, v in azurerm_recovery_services_vault.example : k => v.name if k == "database" }
}