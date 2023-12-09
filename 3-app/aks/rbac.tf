/*
resource "azurerm_role_assignment" "cluster-admin" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "Azure Kubernetes Service RBAC Cluster Admin"
  scope                            = azurerm_kubernetes_cluster.k8s.id
  skip_service_principal_aad_check = true
}

*/

#Attaching a Container Registry to a Kubernetes Cluster
resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}