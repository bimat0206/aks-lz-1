
resource "random_string" "cluster_name" {
  length  = 4
  special = false
  upper   = false

}
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = "${var.prefix}-${var.aks_cluster_name}-${random_string.cluster_name.id}-aks"
  resource_group_name = var.resource_group_name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = var.aks_vm_size
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.aks_username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
   oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
    msi_auth_for_monitoring_enabled = true
   }
}

# Create Kubernetes service account for accessing Key Vault secrets
resource "kubernetes_service_account" "secret_reader" {
  metadata {
    name = "secret-reader"
  }
}
# Grant cluster role for interacting with Key Vault secrets
resource "kubernetes_cluster_role_binding" "secret_reader_binding" {
  metadata {
    name = "secret-reader-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "keyvault-reader"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.secret_reader.metadata[0].name
    namespace = "default"
  }
}
#Attaching a Container Registry to a Kubernetes Cluster
resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}