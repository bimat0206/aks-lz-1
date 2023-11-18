
variable "resource_group_name" {

}
variable "resource_group_location" {

}
/*
variable "storage_account_id" {

}
variable "storage_file_share_name" {

}
*/
variable "prefix" {
  type = string
}

variable "resource_labels" {
  type = map(string)
}
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
    backup = list(object({
      frequency = string
      time      = string
    }))
    retention_daily = list(object({
      count = number
    }))
  }))
}