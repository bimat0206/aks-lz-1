tenant = "panasonic"

domain_name = "dxgcloud"

enable_internal_user = true  # Enable user resource creation
enable_guest_user    = false # Enable user resource creation
enable_group_member  = true
enable_groups        = true

/*
{
  "appId": "f7850452-f37c-4287-8606-c4ce2df7757f",
  "displayName": "terraform",
  "password": "r2C8Q~ElSY4TpdSK1q_EbioTNDop_POz.XMwSaaI",
  "tenant": "2bd6ad95-d0bf-4876-b6a2-3ccea9a4d9c6"
}
*/

resource_groups = {
  "recovery-center" = "Southeast Asia"
  "gorvernace"      = "Southeast Asia"
}
resource_labels = {
  project     = "aks-migration",
  creator     = "manhht6",
  #costcenter  = "panasonic",
  status      = "active",
  environment = "prod"
}


storage_accounts = {
  "account1" = {
    storage_account = {
      name                = "abc"
      location            = "Southeast Asia"
      account_replication = "LRS"
      account_tier        = "Standard"
    }
  }
  # Add more storage accounts as needed
}


storage_container1 =  ["0-gorvenance-tfstate","1-connectivity-tfstate","2-base-services-tfstate","3-app-tfstate"]


vaults=[ "virtual-machine"]

 vm_policies = {
    "example1" = {
      name           = "daily-policy"
      recovery_vault_name = "virtual-machine"
      backup = [
        {
          frequency = "Daily"
          time      = "02:00"
        }
      ]
      retention_daily = [
        {
          count = 30
        }
      ]
    }
  }
/*
  vm_workload_policies = {
  "example1" = {
    name           = "db-daily-policy"
    recovery_vault_name = "database"
    workload_type  = "SQLDatabase"
    protection_policy = [
      {
        policy_type = "Full"
        backup = [
          {
            frequency = "Daily"
            time      = "02:00"
          }
        ]
        retention_daily = [
          {
            count = 30
          }
        ]
      }
    ]
  }
}
*/