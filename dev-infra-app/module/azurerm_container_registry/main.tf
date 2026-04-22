resource "azurerm_container_registry" "acr" {
  for_each = var.acr

  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = "Premium"
  admin_enabled       = false

  tags = each.value.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.acr

  name                = each.value.aks_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uami[each.key].id]
  }

  tags = each.value.tags
}


resource "azurerm_user_assigned_identity" "uami" {

  for_each = var.acr

  location            = each.value.location
  name                = each.value.user_assigned_identity_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull" {
  for_each   = var.acr
  depends_on = [azurerm_kubernetes_cluster.aks]

  principal_id         = azurerm_user_assigned_identity.uami[each.key].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr[each.key].id
}



