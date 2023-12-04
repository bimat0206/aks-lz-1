

domain_name = "dxgcloud"
tenant      = "panasonic"

resource_labels = {
  project = "migration",
  creator = "manhht6",
  #costcenter  = "panasonic",
  status       = "active",
  environment  = "prod"
  businessUnit = "IT",
  #application = "Logistic"
}

vms = [
  {
    name = "vm-2"
    #vm_size               = "Standard_F2s_v2"
    vm_size         = "Standard_B4s_v2"
    admin_username  = "adminuser"
    admin_password  = "Password12345!" # Replace with your password
    os_disk_size_gb = 50
    publisher       = "MicrosoftWindowsServer"
    offer           = "WindowsServer"
    sku             = "2022-Datacenter"
    version         = "latest"
  }
  # Add more VM configurations as needed
]

servers = {
  server1 = {
    server_name                  = "server1"
    administrator_login          = "sqladmin"
    administrator_login_password = "Password12345!"
  }
}

databases = {
  database1 = {
    server_name   = "server1"
    database_name = "database1"
  }
}

resource_groups = {
  "container" = "Southeast Asia"
}

container_registry_name = ["app"]
