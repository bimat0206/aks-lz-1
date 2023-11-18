subscription_id = "82fe0e41-b629-46fb-a653-35956fc09fc7"
client_id       = "ade7aa67-cf61-481c-b182-72cd1d1ac55d"
client_secret   = "c3o8Q~3nI5nhN9uFstB74an96ZF-qVA3cKBgZcKy"
tenant_id       = "40d6ff22-a9f9-427c-9600-0d89aab1c665"

domain_name = "panasonicrd9"
tenant      = "panasonic"

resource_labels = {
  project     = "migration",
  creator     = "manhht6",
  costcenter  = "panasonic",
  status      = "active",
  environment = "prod"
      businessUnit = "IT",
  application = "Logistic"
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
