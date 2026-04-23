resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = each.value.resource_group_name
  location = each.value.location
  tags     = each.value.tags
}

variable "resource_groups" {
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = map(string)
  }))
}