#start
resource "azurerm_automation_runbook" "aks-r1" {
  name                    = "Start-aks-cluster"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "An Azure Automation Gallery Runbook for stopping and starting your AKS Cluster"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/finoops/aks-cluster-changestate/main/aks-cluster-changestate.ps1"
  }
}
resource "azurerm_automation_job_schedule" "aks-r1" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  schedule_name           = azurerm_automation_schedule.aks-r1.name
  runbook_name            = azurerm_automation_runbook.aks-r1.name

  parameters = {
    operation = "start"
    resourcegroupname = "${var.prefix}-spoke1-rg"
    aksclustername = var.aks_cluster_name

  }
}
resource "azurerm_automation_schedule" "aks-r1" {
  name                    = "Start-AKS-cluster-automation-schedule"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  frequency               = "Day"
  interval                = 1
  timezone                = "Asia/Bangkok"
  start_time              = local.future_time
  description             = "This is an example schedule"
          lifecycle {
    ignore_changes = [start_time]
  }
}

#stop
resource "azurerm_automation_runbook" "aks-r2" {
  name                    = "Stop-aks-cluster"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "An Azure Automation Gallery Runbook for stopping and starting your AKS Cluster"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/finoops/aks-cluster-changestate/main/aks-cluster-changestate.ps1"
  }
}
resource "azurerm_automation_job_schedule" "aks-r2" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  schedule_name           = azurerm_automation_schedule.aks-r2.name
  runbook_name            = azurerm_automation_runbook.aks-r2.name

  parameters = {
    operation = "stop"
    resourcegroupname = "${var.prefix}-spoke1-rg"
    aksclustername = var.aks_cluster_name

  }
}
resource "azurerm_automation_schedule" "aks-r2" {
  name                    = "Stop-AKS-cluster-automation-schedule"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.example.name
  frequency               = "Day"
  interval                = 1
  timezone                = "Asia/Bangkok"
  start_time              = local.future_time
  description             = "This is an example schedule"
          lifecycle {
    ignore_changes = [start_time]
  }
}