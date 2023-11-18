
variable "domain_name" { }
variable "subscription_id" { }
variable "enable_internal_user" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_guest_user" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_groups" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}

variable "enable_group_member" {
  description = "Flag to enable or disable user resource creation"
  type        = bool
}
