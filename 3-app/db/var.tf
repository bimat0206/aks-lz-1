variable "servers" {
  type = map(object({
    server_name = string
    administrator_login = string
    administrator_login_password = string
  }))
}

variable "databases" {
  type = map(object({
    server_name = string
    database_name = string
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
variable "subnet_name" {
}
variable "virtual_network_name" {
}