variable "public_ips" {
  type = list(object({
    name                = string
    allocation_method   = string
    resource_group_name =string
  }))
  
}
variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}



variable "location" {
  type = string
}