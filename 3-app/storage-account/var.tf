variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
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

variable "resource_groups_name" {

}


 
variable "storage_container1" {
  type = list(string)

}
