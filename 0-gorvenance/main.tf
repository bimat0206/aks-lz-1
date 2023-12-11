
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
*/
module "identity_ad" {
  source               = "./identity"
  domain_name          = var.domain_name
  subscription_id      = var.subscription_id
  enable_internal_user = var.enable_internal_user
  enable_guest_user    = var.enable_guest_user
  enable_group_member  = var.enable_group_member
  enable_groups        = var.enable_groups

}


####role assignments
data "azurerm_automation_account" "example" {
  name                = "${local.prefix}-1-automation-acc"
  resource_group_name = module.resource_groups.gorvernace_resource_group_name
  depends_on = [ module.automation ]
}

module "role_assignments" {
  source = "./role-assignments"
  domain_name = var.domain_name
  subscription_id = var.subscription_id
  depends_on = [ module.policy , module.automation]
role_assignment = local.role_assignment
}


locals {
  role_assignment = [
    {
      principal_object_id                = data.azurerm_automation_account.example.identity[0].principal_id
      role_name   = "Owner"
    },
    {
      principal_object_id                = module.identity_ad.azuread_group1_id
      role_name   = "Azure Kubernetes Service RBAC Cluster Admin"
    }
  ]
}


### group_member_assignment
module "group_member_assignment" {
  source = "./group-member-assignments"
  depends_on = [ module.identity_ad ]
group_member_assignment = local.group_member_assignment
}

locals {
  group_member_assignment = [
    {
      group_object_id    = module.identity_ad.azuread_group1_id
      member_object_id   = data.azuread_user.example.id
    },
        {
      group_object_id    = module.identity_ad.azuread_group1_id
      member_object_id   = data.azurerm_automation_account.example.identity[0].principal_id
    }
  ]
}

data "azuread_user" "example" {
  user_principal_name = "manhht6_fpt.com#EXT#@dxgcloud.onmicrosoft.com"
}


#####
module "resource_groups" {
  source          = "./resource-groups"
  resource_groups = var.resource_groups
  resource_labels = local.resource_labels
  prefix          = local.prefix
  depends_on      = [module.policy]


}
/*
module "storage_account" {
  source               = "./storage-account"
  resource_groups_name = module.resource_groups.gorvernace_resource_group_name
  resource_labels      = local.resource_labels
  prefix               = local.prefix
  storage_accounts     = var.storage_accounts
  #storage_file_share = var.storage_file_share
storage_container1    = var.storage_container1

}

*/
###policy
module "policy" {
  source = "./policy"
  prefix = local.prefix
  #subscription_id=var.subscription_id


}
module "backup" {
  source = "./backup"

  prefix                  = local.prefix
  resource_group_name     = module.resource_groups.recovery_resource_group_name
  resource_group_location = module.resource_groups.recovery_resource_group_location
  resource_labels         = local.resource_labels
  vaults = var.vaults
#vm_workload_policies = var.vm_workload_policies
vm_policies = var.vm_policies
  #storage_file_share_name = module.storage_account.account1_storage_file_share_name
  #storage_account_id      = module.storage_account.account1_storage_account_id
  
}

module "security-center" {
  source = "./security-center"

  prefix                  = local.prefix
  resource_group_name     = module.resource_groups.gorvernace_resource_group_name
  resource_group_location = module.resource_groups.gorvernace_resource_group_location
  resource_labels         = local.resource_labels
  subscription_id = var.subscription_id

}

module "cost-management" {
  source = "./cost-management"

}

module "automation" {
  source          = "./automation"
  resource_labels = local.resource_labels
  prefix          = local.prefix
  subscription_id      = var.subscription_id

resource_group_name = module.resource_groups.gorvernace_resource_group_name
resource_group_location = module.resource_groups.gorvernace_resource_group_location

aks_cluster_name = "prod-migration-voting-app-okl5-aks"
}
