
resource "azuread_group" "groups" {
  for_each = var.enable_groups ? { for row in local.group_data : row.display_name => row } : {}

  display_name     = each.key
  mail_enabled = true
  description      = each.key
  mail_nickname     = each.value.mail_nickname
  types = ["Unified"]
}


locals {
  group_data        = jsondecode(file("${path.module}/./conf/groups_ad.json"))
  #group_memberships = jsondecode(file("${path.module}/./conf/group_member.json")).memberships
  #group_member_map  = { for membership in local.group_memberships : "${membership.user_name}-${membership.group_name}" => membership }
}
/*
# Assign users to groups

resource "null_resource" "group_memberships" {
  for_each = local.group_member_map
}

resource "azuread_group_member" "member" {
  for_each = var.enable_group_member ? local.group_member_map : {}

  group_object_id  = azuread_group.groups[each.value.group_name].id
  member_object_id = azuread_user.users[each.value.user_name].principal_id
}
*/