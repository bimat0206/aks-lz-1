variable "group_member_assignment" {
  type = list(object({
    group_object_id                = string
    member_object_id   = string
  }))
  
}