locals {
  prefix = "${var.resource_labels["environment"]}-${var.resource_labels["project"]}"
  resource_labels = merge(var.resource_labels, {
    environment = "prod"
  })
}
/*
locals {
  prefix = "${var.tenant}-${var.resource_labels["environment"]}-${var.resource_labels["project"]}"
  resource_labels = merge(var.resource_labels, {
    environment = "prod"
  })
}

module "windows-vm" {
  source          = "./windows-vm"
  resource_labels = local.resource_labels
  prefix          = local.prefix
  vms = var.vms
resource_group_name = "${local.prefix}-spoke1-rg"
virtual_network_name = "${local.prefix}-spoke1-vt"
subnet_name = "${local.prefix}-spoke1-public-subnet"
#public_ip_name = "${local.prefix}-spoke-public1"
}

module "ms_sql_server" {
  source          = "./db"
  resource_labels = local.resource_labels
  prefix          = local.prefix

resource_group_name = "${local.prefix}-spoke1-rg"
subnet_name = "${local.prefix}-spoke1-public-subnet"
virtual_network_name = "${local.prefix}-spoke1-vt"
mssql_servers = var.mssql_servers
databases=var.databases
}
*/

module "psql1" {
  source          = "./psql-db"
  resource_labels = local.resource_labels
  prefix          = local.prefix
psql_servers = var.psql_servers1

resource_group_name = "${local.prefix}-spoke1-rg"
resource_group_location = data.azurerm_resource_group.spoke1.location

}

module "resource_groups" {
  source          = "./resource-groups"
  resource_groups = var.resource_groups
  resource_labels = local.resource_labels
  prefix          = local.prefix


}
module "container-registry" {
  source = "./container-registry"

  resource_labels         = local.resource_labels
  container_registry_name = var.container_registry_name
  resource_group_name     = module.resource_groups.container_resource_group_name
  resource_group_location = module.resource_groups.container_resource_group_location
  prefix                  = local.prefix


}
data "azurerm_resource_group" "spoke1" {
  name = "${local.prefix}-spoke1-rg"
}
module "aks1" {
  source = "./aks"
  resource_group_name     = "${local.prefix}-spoke1-rg"
  resource_group_location = data.azurerm_resource_group.spoke1.location
  resource_group_id=  data.azurerm_resource_group.spoke1.id
  prefix                  = local.prefix
resource_labels         = local.resource_labels
tenant_id = var.tenant_id
node_count ="2"
aks_username="admin1234"
aks_cluster_name="voting-app"
aks_vm_size="Standard_D2_v2"
acr_id= module.container-registry.acr_id_0
}

module "storage_account" {
  source               = "./storage-account"
  resource_groups_name = "${local.prefix}-gorvernace-rg"
  resource_labels      = local.resource_labels
  prefix               = local.prefix
  storage_accounts     = var.storage_accounts
  #storage_file_share = var.storage_file_share
storage_container1    = var.storage_container1

}
module "monitor-metric-alert1" {
  source               = "./monitor-metric-alert"
  resource_group_name = "${local.prefix}-gorvernace-rg"
  resource_labels      = local.resource_labels
  prefix               = local.prefix
metric_alert = var.metric_alert1
action_group= var.action_group1
metric_alert_scopes = [module.aks1.aks_id]

}