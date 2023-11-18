

variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}
variable "vnet_location" {
  type = string
}

variable "resource_group_name" {
}


variable "networks" {
  type = map(object({
    name          = string
    address_space = list(string)
    subnets       = map(object({
      name          = string
      address_prefix = string
    }))
  }))

 
}
