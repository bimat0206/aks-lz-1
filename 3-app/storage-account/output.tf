


output "account1_storage_account_name" {
  value = azurerm_storage_account.example["account1"].name
}

/*
output "account1_storage_file_share_name" {
  value = azurerm_storage_share.example["account1"].name
}

output "account2_storage_file_share_name" {
  value = azurerm_storage_share.example["account2"].name
}
*/