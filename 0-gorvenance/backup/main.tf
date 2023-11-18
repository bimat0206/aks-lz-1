
# Load backup policy data from JSON file

locals {
  vm_policies = jsondecode(file("${path.module}/conf/vm_policy.json"))
  workload_policies = jsondecode(file("${path.module}/conf/workload_policy.json"))
}

# Create backup vaults
/*
resource "azurerm_recovery_services_vault" "example" {
  count               = length(local.backup_policies)
  name                = "${local.backup_policies[count.index].resource_type}-vault"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  #storage_mode_type = "${local.backup_policies[count.index].storage_mode_type}"
  sku          = "Standard"
  tags = var.resource_labels
  monitoring  {
    alerts_for_all_job_failures_enabled = true
  }
}
*/
resource "azurerm_recovery_services_vault" "example" {
  for_each = toset(var.vaults)

  name                = "${each.key}-vault"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
    tags = var.resource_labels
  monitoring  {
    alerts_for_all_job_failures_enabled = true
  }
}

# Create backup policies
# Create VM workload policies
/*
resource "azurerm_backup_policy_vm_workload" "example" {
  for_each = var.vm_workload_policies

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = "${each.value.recovery_vault_name}-vault"
  workload_type       = each.value.workload_type

  settings {
    time_zone           = "UTC+7"
    compression_enabled = true
  }

  dynamic "protection_policy" {
    for_each = each.value.protection_policy

    content {
      policy_type = protection_policy.value.policy_type

      backup {
        frequency = protection_policy.value.backup.frequency
        time      = protection_policy.value.backup.time
      }

      retention_daily {
        count = protection_policy.value.retention_daily.count
      }
    }
  }
}

# Create VM policies
resource "azurerm_backup_policy_vm" "example" {
  for_each = var.vm_policies

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = "virtual-machine-vault"
  timezone            = "UTC+7"

  dynamic "backup" {
    for_each = each.value.backup

    content {
      frequency = backup.value.frequency
      time      = backup.value.time
    }
  }

  dynamic "retention_daily" {
    for_each = each.value.retention_daily

    content {
      count = retention_daily.value.count
    }
  }
}

/*
resource "azurerm_backup_container_storage_account" "storage_account" {
    count               = length(local.backup_policies)
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.example[count.index].name
  storage_account_id        = var.storage_account_id
  #backup_policy_id    = azurerm_backup_policy_vm.example[count.index].id
}
resource "azurerm_backup_protected_file_share" "share1" {
    count               = length(local.backup_policies)
  resource_group_name       = var.resource_group_name
  recovery_vault_name       = azurerm_recovery_services_vault.example[count.index].name
  source_storage_account_id = var.storage_account_id
  source_file_share_name    = var.storage_file_share_name
  backup_policy_id          = azurerm_backup_policy_file_share.example[count.index].id
}
*/