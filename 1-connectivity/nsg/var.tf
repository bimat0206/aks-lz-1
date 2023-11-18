variable "network_security_groups" {
  description = "A map of network security groups and their rules."
  type        = map(object({
    name  = string
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


variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}
variable "resource_group_location" {

}
variable "resource_group_name" {

}

