locals {
  timestamp = "${timestamp()}"
}
resource "azurerm_automation_account" "example" {
  name                = "${var.prefix}-1-automation-acc"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
  sku_name            = "Basic"

tags     = var.resource_labels
}

#start
resource "azurerm_automation_runbook" "r1" {
  name                    = "Start-AzureVM"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This runbook connects to Azure using system assigned identity and starts all V2 VMs in an Azure subscription or resource group or a single named V2 VM."
  runbook_type            = "GraphPowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/azureautomation/start-azure-v2-vms/master/StartAzureV2Vm.graphrunbook"
  }
}


resource "azurerm_automation_job_schedule" "example" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  schedule_name           = azurerm_automation_schedule.example.name
  runbook_name            = azurerm_automation_runbook.r1.name

  parameters = {
    subscription = "20bbbfd5-6acc-440e-8864-acde177794d4"
    #RESOURCEGROUPNAME        = "TF-VM-01"

  }
}

resource "azurerm_automation_schedule" "example" {
  name                    = "Start-AzureVM-automation-schedule"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  frequency               = "Day"
  interval                = 1
  timezone                = "Asia/Bangkok"
  start_time              = local.timestamp
  description             = "This is an example schedule"
          lifecycle {
    ignore_changes = [start_time]
  }
}

#stop
resource "azurerm_automation_runbook" "r2" {
  name                    = "Stop-AzureVM"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This runbook connects to Azure using system assigned identity and stop all V2 VMs in an Azure subscription or resource group or a single named V2 VM."
  runbook_type            = "GraphPowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/azureautomation/stop-azure-v2-vms/master/StopAzureV2Vm.graphrunbook"
  }
}


resource "azurerm_automation_job_schedule" "r2" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  schedule_name           = azurerm_automation_schedule.r2.name
  runbook_name            = azurerm_automation_runbook.r2.name

  parameters = {
    subscription = "20bbbfd5-6acc-440e-8864-acde177794d4"
    #RESOURCEGROUPNAME        = "TF-VM-01"

  }
}

resource "azurerm_automation_schedule" "r2" {
  name                    = "Stop-AzureVM-automation-schedule"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  frequency               = "Day"
  interval                = 1
  timezone                = "Asia/Bangkok"
  start_time              = local.timestamp
  description             = "This is an example schedule"
        lifecycle {
    ignore_changes = [start_time]
  }
}

