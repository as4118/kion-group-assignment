
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each            = var.acr
  name                = each.value.log_analytics_workspace_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_container_registry" "acr" {
  for_each = var.acr

  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = "Premium"
  admin_enabled       = false

  tags = each.value.tags
}


resource "azurerm_user_assigned_identity" "uami" {
  for_each = var.acr

  name                = each.value.user_assigned_identity_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.acr

  name                = each.value.aks_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  kubernetes_version = each.value.kubernetes_version

  default_node_pool {
    name       = "system"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size

    min_count            = each.value.min_count
    max_count            = each.value.max_count
    os_disk_size_gb      = 50
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uami[each.key].id]
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  oms_agent {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  }

  tags = each.value.tags
}


resource "azurerm_role_assignment" "acr_pull" {
  for_each = var.acr

  principal_id         = azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr[each.key].id
}