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

variable "firewalls" {
  type = map(object({
    name                = string

    public_ip_address_id   = string
    subnet_id            = string
  }))
}