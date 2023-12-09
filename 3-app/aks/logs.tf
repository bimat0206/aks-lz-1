# Create a Log Analytics workspace for monitoring
resource "azurerm_log_analytics_workspace" "k8s_log" {
  name                = "${var.prefix}-${var.aks_cluster_name}-${random_string.cluster_name.id}-log"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
   tags = var.resource_labels
  sku                 = "PerGB2018"
  retention_in_days   = 30
              lifecycle {
    ignore_changes = [name]
  }
}


# Create a Log Analytics solution for container monitoring
resource "azurerm_log_analytics_solution" "k8s_log" {
solution_name         = "ContainerInsights"
location              = var.resource_group_location
resource_group_name   = var.resource_group_name
 tags = var.resource_labels
workspace_resource_id = azurerm_log_analytics_workspace.k8s_log.id
workspace_name        = azurerm_log_analytics_workspace.k8s_log.name

plan {
publisher = "Microsoft"
product   = "OMSGallery/ContainerInsights"
}
              lifecycle {
    ignore_changes = [solution_name]
  }
}

resource "azurerm_log_analytics_workspace" "k8s_defender" {
  name                = "${var.prefix}-${var.aks_cluster_name}-${random_string.cluster_name.id}-microsoft-defender-log"
  location            = var.resource_group_location
   tags = var.resource_labels
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
              lifecycle {
    ignore_changes = [name]
  }
}
