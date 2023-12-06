# Create a Log Analytics workspace for monitoring
resource "azurerm_log_analytics_workspace" "example" {
  name                = "${var.prefix}-${var.aks_cluster_name}-${random_string.cluster_name.id}-log"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
              lifecycle {
    ignore_changes = [name]
  }
}


# Create a Log Analytics solution for container monitoring
resource "azurerm_log_analytics_solution" "example" {
solution_name         = "ContainerInsights"
location              = var.resource_group_location
resource_group_name   = var.resource_group_name
workspace_resource_id = azurerm_log_analytics_workspace.example.id
workspace_name        = azurerm_log_analytics_workspace.example.name

plan {
publisher = "Microsoft"
product   = "OMSGallery/ContainerInsights"
}
}