variable "resource_group_location" {

}
variable "resource_group_name" {

}


variable "resource_labels" {
    type = map(string)

}
variable "prefix" {
  type = string
}

variable "container_registry_name" {
 type = list(string)
}