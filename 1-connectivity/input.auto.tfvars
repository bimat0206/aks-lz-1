

domain_name = "dxgcloud"
#tenant      = "panasonic"
resource_labels = {
  project     = "migration",
  creator     = "manhht6",
  #costcenter  = "panasonic",
  status      = "active",
  environment = "prod"
      businessUnit = "IT",
  #application = "Logistic"
}



resource_groups = {
  "network" = "Southeast Asia"
}

networks1 = {
  network1 = {
    name          = "hub"
    address_space = ["10.0.0.0/16"]
    subnets = {
      subnet1 = {
        name           = "hub-public-subnet"
        address_prefix = "10.0.1.0/24"
      }
      subnet2 = {
        name           = "hub-private-subnet"
        address_prefix = "10.0.2.0/24"
      }
            subnet3 = {
        name           = "AzureFirewallSubnet"
        address_prefix = "10.0.3.0/26"
      }
    }
  }
}
networks2 = {
  spoke1 = {
    name          = "spoke1"
    address_space = ["192.168.0.0/16"]
    subnets = {
      subnet1 = {
        name           = "prod-migration-spoke1-public-subnet"
        address_prefix = "192.168.1.0/24"
      }
      subnet2 = {
        name           = "prod-migration-spoke1-private-subnet"
        address_prefix = "192.168.2.0/24"
      }
    }
  }
}
network_security_groups = {
  "rule1-nsg" = {
    name = "spoke1"
    rules = [
      {
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-https"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-ssh"
        priority                   = 103
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
    "rule2-nsg" = {
    name = "hub"
    rules = [
      {
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-https"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-ssh"
        priority                   = 103
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}
