

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

mssql_servers = {
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


psql_servers1 = {
    server_name                  = "votingapp"
    version = "15"
      storage_mb = "65536"
      sku_name = "B_Standard_B2s"
}

resource_groups = {
  "container" = "Southeast Asia"
}

container_registry_name = ["app"]
storage_accounts = {
  "account1" = {
    storage_account = {
      name                = "aksbackup"
      location            = "Southeast Asia"
      account_replication = "LRS"
      account_tier        = "Standard"
    }
  }
  # Add more storage accounts as needed
}


storage_container1 =  ["prod-migration-voting-app-okl5-aks"]
