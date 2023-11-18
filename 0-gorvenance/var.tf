variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "domain_name" {}

variable "enable_internal_user" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_guest_user" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_groups" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_group_member" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}


variable "resource_groups" {
  type = map(string)
}
variable "resource_labels" {
  type = map(string)
}
variable "tenant" {
  type = string
}


variable "storage_accounts" {
  type = map(object({
    storage_account = object({
      name                = string
      location            = string
      account_replication = string
      account_tier        = string
    })
  }))
}

variable "storage_container1" {
type=list(string)
}
/*
variable "storage_file_share" {
  type = map(object({
    file_share = object({
      name                = string
    })
  }))
}
*/
variable "vaults" {
  description = "List of vaults and associated policies"
  type        = list
}
/*
variable "vm_workload_policies" {
  type = map(object({
    name              = string
    recovery_vault_name = string
    workload_type     = string
    protection_policy = list(object({
      policy_type      = string
      backup           = object({
        frequency = string
        time      = string
      })
      retention_daily = object({
        count = number
      })
    }))
  }))
}
*/

# Define your VM policies in a map
variable "vm_policies" {
  type = map(object({
    name           = string
    recovery_vault_name = string
    backup = list(object({
      frequency = string
      time      = string
    }))
    retention_daily = list(object({
      count = number
    }))
  }))
}