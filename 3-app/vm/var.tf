variable "vms" {
  type = list(object({
    name                  = string
    vm_size               = string
    admin_username        = string
    admin_password        = string
    os_disk_size_gb       = number
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
  }))

}

variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}


variable "resource_group_name" {
}


variable "virtual_network_name" {
}
variable "subnet_name" {
}
/*
variable "public_ip_name" {
}
*/