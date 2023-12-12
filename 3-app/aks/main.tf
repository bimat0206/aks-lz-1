
resource "random_string" "cluster_name" {
  length  = 4
  special = false
  upper   = false

}

resource "random_string" "azurerm_kubernetes_cluster_dns_prefix" {
  length  = 4
  special = false
  upper   = false

}
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = "${var.prefix}-${var.aks_cluster_name}-${random_string.cluster_name.id}-aks"
  resource_group_name = var.resource_group_name
  dns_prefix          = random_string.azurerm_kubernetes_cluster_dns_prefix.id
  tags = var.resource_labels

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = var.aks_vm_size
    node_count = var.node_count
    #os_sku   = "AzureLinux"
  }
  /*
  linux_profile {
    admin_username = var.aks_username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  */
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_mode = "transparent"
    network_policy ="cilium"
    ebpf_data_plane = "cilium"
    network_plugin_mode = "overlay"
  }
   oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s_log.id
    msi_auth_for_monitoring_enabled = true
   }

   microsoft_defender{
    log_analytics_workspace_id =azurerm_log_analytics_workspace.k8s_defender.id
   }
   azure_active_directory_role_based_access_control{
managed = true
azure_rbac_enabled = true

   }

   key_vault_secrets_provider{
    secret_rotation_enabled = true
   }

   storage_profile{
      blob_driver_enabled         = true
      disk_driver_enabled         = true
      disk_driver_version         = "v1"
      file_driver_enabled         = true
      snapshot_controller_enabled = true
}
}

