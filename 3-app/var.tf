variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "domain_name" {}

variable "resource_labels" {
  type = map(string)
}
variable "tenant" {
  type = string
}
variable "vms" {
  type = list(object({
    name            = string
    vm_size         = string
    admin_username  = string
    admin_password  = string
    os_disk_size_gb = number
    publisher       = string
    offer           = string
    sku             = string
    version         = string
  }))

}
/*
variable "servers" {
  type = map(object({
    server_name                  = string
    administrator_login          = string
    administrator_login_password = string
  }))
}
*/
variable "mssql_servers" {
  type = map(object({
    server_name                  = string
    administrator_login          = string
    administrator_login_password = string
  }))
}

variable "databases" {
  type = map(object({
    server_name   = string
    database_name = string
  }))
}


variable "psql_servers1" {
  type = map(string)
}

variable "resource_groups" {
  type = map(string)
}


variable "container_registry_name" {
  type = list(string)
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