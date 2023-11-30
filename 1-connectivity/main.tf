
locals {
  prefix = "${var.resource_labels["environment"]}-${var.resource_labels["project"]}"
  resource_labels = merge(var.resource_labels, {
    environment = "prod"
  })
}
/*
locals {
  prefix = "${var.tenant}-${var.resource_labels["environment"]}-${var.resource_labels["project"]}"
  resource_labels = merge(var.resource_labels, {
    environment = "prod"
  })
}
*/

module "resource_groups" {
  source          = "./resource-groups"
  resource_groups = var.resource_groups
  resource_labels = local.resource_labels
  prefix          = local.prefix


}



### hub network

module "virtual_network1" {
  source          = "./vpc" # Update to the path of your module
  resource_labels = local.resource_labels
  prefix          = local.prefix
  #resource_groups        = var.resource_groups
  networks = var.networks1
  #subnets      = var.subnets
  resource_group_name     = "hub"
  vnet_location           = "Southeast Asia"

}

### spoke network

module "virtual_network2" {
  source          = "./vpc" # Update to the path of your module
  resource_labels = local.resource_labels
  prefix          = local.prefix
  #resource_groups        = var.resource_groups
  networks = var.networks2
  #subnets      = var.subnets
  resource_group_name     = "spoke1"
  vnet_location           = "Southeast Asia"
}

### find resource group for network manager

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}



data "azurerm_virtual_network" "hub" {
  name                = module.virtual_network1.virtual_network_names[0]
  resource_group_name = module.virtual_network1.virtual_network_resource_group
  depends_on          = [module.virtual_network2]
}
data "azurerm_virtual_network" "spoke" {
  name                = module.virtual_network2.virtual_network_names[0]
  resource_group_name = module.virtual_network2.virtual_network_resource_group
  depends_on          = [module.virtual_network2]
}

module "network_manager" {
  source                     = "./network-manager"
  resource_labels            = local.resource_labels
  prefix                     = local.prefix
  subscription_id            = data.azurerm_subscription.current.id
  resource_group_name        = module.resource_groups.network_resource_group_name
  resource_group_location    = module.resource_groups.network_resource_group_location
  hub_resource_id            = data.azurerm_virtual_network.hub.id
  target_virtual_network_id1 = data.azurerm_virtual_network.hub.id
  target_virtual_network_id2= data.azurerm_virtual_network.spoke.id

  depends_on = [module.virtual_network1]
}
module "nsg" {
  source          = "./nsg" # Update to the path of your module
  resource_labels = local.resource_labels
  prefix          = local.prefix
network_security_groups = var.network_security_groups
resource_group_name        = module.resource_groups.network_resource_group_name
  resource_group_location    = module.resource_groups.network_resource_group_location
}


data "azurerm_subnet" "spoke1" {
  name                 = "prod-migration-spoke1-public-subnet"
  virtual_network_name = "${local.prefix}-spoke1-vt"
  resource_group_name  = "${local.prefix}-spoke1-rg"
  depends_on = [ module.virtual_network1, module.virtual_network2 ]
}
data "azurerm_subnet" "hub-public" {
  name                 = "hub-public-subnet"
  virtual_network_name = "${local.prefix}-hub-vt"
  resource_group_name  = "${local.prefix}-hub-rg"
  depends_on = [ module.virtual_network1, module.virtual_network2 ]
}
data "azurerm_subnet" "hub-private" {
  name                 = "hub-private-subnet"
  virtual_network_name = "${local.prefix}-hub-vt"
  resource_group_name  = "${local.prefix}-hub-rg"
  depends_on = [ module.virtual_network1, module.virtual_network2 ]
}
data "azurerm_subnet" "hub-fw" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = "${local.prefix}-hub-vt"
  resource_group_name  = "${local.prefix}-hub-rg"
  depends_on = [ module.virtual_network1, module.virtual_network2 ]
}
locals {
 subnet_nsg_associations = {
  "subnet1" = {
      subnet_id  = data.azurerm_subnet.spoke1.id
      nsg_id     = module.nsg.spoke1_nsg_id
    }
      "subnet2" = {
      subnet_id  = data.azurerm_subnet.hub-public.id
      nsg_id     = module.nsg.hub_nsg_id
    }
          "subnet3" = {
      subnet_id  = data.azurerm_subnet.hub-private.id
      nsg_id     = module.nsg.hub_nsg_id
    }
 }
}
module "nsg-association" {
  source          = "./nsg-association" 
  
subnet_nsg_associations = local.subnet_nsg_associations

}

data "azurerm_public_ip" "hub-fw" {
  name                = "${local.prefix}-hub-public1-ip"
  resource_group_name = "${local.prefix}-hub-rg"
  depends_on = [  module.public_ip]
}

locals {
 firewalls = {
  "fw1" = {
    name = "${local.prefix}-hub-fw"
      subnet_id  = data.azurerm_subnet.hub-fw.id
      public_ip_address_id     = data.azurerm_public_ip.hub-fw.id
    }
 }
}
module "firewall" {
  source          = "./firewalls" 
  
resource_labels = local.resource_labels
prefix          = local.prefix
firewalls = local.firewalls
resource_group_name        = "${local.prefix}-hub-rg"
resource_group_location    = "Southeast Asia"
depends_on = [ module.resource_groups ]
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
  depends_on = [ module.resource_groups ]
}

module "vpn" {
  source          = "./vpn"
  virtual_network_name= "${local.prefix}-hub-vt"
  virtual_network_resource_group_name= "${local.prefix}-hub-rg"
  resource_group_location= "Southeast Asia"
  
    resource_labels = local.resource_labels
  prefix          = local.prefix
}