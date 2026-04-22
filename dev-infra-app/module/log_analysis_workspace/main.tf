data "azurerm_resource_group" "example" {
  for_each = var.log_analytics_workspace
  name     = each.value.resource_group_name
}

resource "azurerm_log_analytics_workspace" "example" {
  for_each            = var.log_analytics_workspace

  name                = each.value.workspace_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

