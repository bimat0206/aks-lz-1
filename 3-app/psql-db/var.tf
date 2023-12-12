variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}

variable "resource_group_name" {
}
variable "resource_group_location" {
}
variable "psql_servers" {
 type = map(string)
}