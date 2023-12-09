
resource "azuread_group" "groups" {
  for_each = var.enable_groups ? { for row in local.group_data : row.display_name => row } : {}

  display_name     = each.key
  #mail_enabled = true
  security_enabled = true
  description      = each.key
  #mail_nickname     = each.value.mail_nickname
  #types = ["DynamicMembership"]
}


locals {
  group_data        = jsondecode(file("${path.module}/./conf/groups_ad.json"))
}

