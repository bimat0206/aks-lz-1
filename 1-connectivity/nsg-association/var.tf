variable "subnet_nsg_associations" {
  type = map(object({
    subnet_id  = string
    nsg_id     = string
  }))
}
