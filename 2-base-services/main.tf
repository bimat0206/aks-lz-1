locals {
  prefix = "${var.tenant}-${var.resource_labels["environment"]}-${var.resource_labels["project"]}"
  resource_labels = merge(var.resource_labels, {
    environment = "prod"
  })
}


locals {
  public_ips = [
    {
      name                = "spoke1-public1"
      allocation_method   = "Static"
      resource_group_name = "${local.prefix}-spoke1-rg"
    },
    {
      name                = "hub-public1"
      allocation_method   = "Static"
      resource_group_name = "${local.prefix}-hub-rg"
    },
    {
      name                = "lb"
      allocation_method   = "Static"
      resource_group_name = "${local.prefix}-hub-rg"
    }
    # Add more public IP configurations as needed
  ]
  
  
}
module "public_ip" {
  source          = "./public-ip"
  resource_labels = local.resource_labels
  prefix          = local.prefix
  public_ips = local.public_ips
  location = "Southeast Asia"
}