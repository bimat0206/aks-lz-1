variable "resource_labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}

variable "resource_group_name" {
}
/*
variable "resource_group_location" {
}
*/
variable "metric_alert" {
 type = map(string)
}
variable "action_group" {
 type = map(string)
}
variable "metric_alert_scopes" {
}
