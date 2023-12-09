resource "azuread_group_member" "member" {
  count= length(var.group_member_assignment)
  group_object_id  = var.group_member_assignment[count.index].group_object_id
  member_object_id = var.group_member_assignment[count.index].member_object_id
}