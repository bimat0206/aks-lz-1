
# Read user and group data from the JSON file
locals {
  internal_user = jsondecode(file("${path.module}/./conf/internal_user.json"))
  guest_user = jsondecode(file("${path.module}/./conf/guest_user.json"))
}

# Create Azure AD users
resource "azuread_user" "users" {
  for_each = var.enable_internal_user ? { for row in local.internal_user : row.user_principal_name => row }  : {}
  account_enabled = each.value.account_enabled
  user_principal_name = "${each.value.user_principal_name}@${var.domain_name}.onmicrosoft.com"
  #user_principal_name = each.value.user_principal_name
  display_name        = each.value.user_display_name
  password            = "admi2#$234BDF@@n1234"
}

/*
# Generate random passwords for users
resource "random_password" "password" {
  for_each = { for row in local.internal_user : row.user_principal_name => row }

  length           = 10
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
*/
# Create Azure AD groups



#Manages an invitation of a guest user within Azure Active Directory.
resource "azuread_invitation" "example" {
  for_each = var.enable_guest_user ? { for row in local.guest_user : row.user_email_address => row }  : {}
  user_email_address = each.value.user_email_address
  redirect_url       = "https://portal.azure.com"

  message {
    language = "en-US"
  }
}
