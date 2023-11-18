variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "domain_name" {}

variable "resource_labels" {
  type = map(string)
}
variable "tenant" {
  type = string
}
