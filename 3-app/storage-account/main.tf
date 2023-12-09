
resource "random_string" "example" {
  length  = 5
  special = false
  lower = true
}


resource "azurerm_storage_account" "example" {
  for_each = var.storage_accounts

  name                     = "${each.value.storage_account.name}000${random_string.example.id}"
  location                 = each.value.storage_account.location
  resource_group_name      = var.resource_groups_name
  account_replication_type = each.value.storage_account.account_replication
  account_tier             = each.value.storage_account.account_tier
  tags                     = var.resource_labels
}

# Create Azure Storage Containers within each Storage Account
resource "azurerm_storage_container" "account1_container_type" {
  count = length(var.storage_container1)

  name                  =  "${var.storage_container1[count.index]}-storage-container"
  storage_account_name  = azurerm_storage_account.example["account1"].name
  container_access_type = "container"
  /*
  metadata              = each.value.metadata

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
  */
  
}
