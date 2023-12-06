variable "resource_group_location" {

}
variable "resource_group_name" {

}
variable "resource_group_id" {

}

variable "resource_labels" {
    type = map(string)

}
variable "prefix" {
  type = string
}
variable "tenant_id" {

}
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "aks_username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}
variable "aks_cluster_name" {

}
variable "aks_vm_size" {
     type        = string
}

variable "acr_id" {
     type        = string
}