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
servers = var.servers
databases=var.databases
}
*/
module "resource_groups" {
  source          = "./resource-groups"
  resource_groups = var.resource_groups
  resource_labels = local.resource_labels
  prefix          = local.prefix


}
module "container-registry" {
  source          = "./container-registry"

  resource_labels = local.resource_labels
  container_registry_name= var.container_registry_name
  resource_group_name        = module.resource_groups.container_resource_group_name
resource_group_location    = module.resource_groups.container_resource_group_location
  prefix          = local.prefix


}

