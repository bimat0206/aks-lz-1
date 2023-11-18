variable "subscription_id" { }
variable "domain_name" {
  type = string
}
variable "role_assignment" {
  type = list(object({
    principal_object_id                = string
    role_name   = string
  }))
  
}