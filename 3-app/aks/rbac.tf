resource "azurerm_role_assignment" "cluster-admin" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "Azure Kubernetes Service RBAC Cluster Admin"
  scope                            = azurerm_kubernetes_cluster.k8s.id
  skip_service_principal_aad_check = true
}
# Create Cluster Role Bindings
resource "kubernetes_cluster_role_binding" "admin_binding" {
  metadata {
    name = "admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.group-admin.display_name
    api_group = "rbac.authorization.k8s.io"
  }
}

data "azuread_group" "group-admin" {
  display_name     = "AKS-Admin-Group"
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