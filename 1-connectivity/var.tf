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

variable "resource_groups" {
  type = map(string)
}


/*
variable "resource_group_name" {
}
variable "resource_group_location" {
}
*/

variable "networks1" {
  type = map(object({
    name          = string
    address_space = list(string)
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))


}
variable "networks2" {
  type = map(object({
    name          = string
    address_space = list(string)
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))


}
variable "network_security_groups" {
  description = "A map of network security groups and their rules."
  type = map(object({
    name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

