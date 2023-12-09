
resource "azurerm_role_assignment" "keyvault1" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "Key Vault Secrets User"
  scope                            = azurerm_kubernetes_cluster.k8s.id
  skip_service_principal_aad_check = true
}
resource "azurerm_role_assignment" "keyvault2" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "Key Vault Administrator"
  scope                            = azurerm_kubernetes_cluster.k8s.id
  skip_service_principal_aad_check = true
}
resource "azurerm_role_assignment" "storage-backup" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "Storage Account Contributor"
  scope                            = azurerm_kubernetes_cluster.k8s.id
  skip_service_principal_aad_check = true
}
data "azurerm_recovery_services_vault" "vault" {
  name                = "aks-backup-vault"
  resource_group_name = "${var.prefix}-recovery-center-rg"
}
resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "example" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  name                  = "aks-backup"
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]
  source_resource_id    = data.azurerm_recovery_services_vault.vault.id
}
#Attaching a Container Registry to a Kubernetes Cluster
resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}