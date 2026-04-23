
data "azurerm_resource_group" "resourcegroup" {
  for_each = var.storage_accounts
  name     = each.value.resource_group_name
}

resource "azurerm_storage_account" "stg_account" {
  for_each                 = var.storage_accounts
  depends_on               = [data.azurerm_resource_group.resourcegroup]
  name                     = each.value.name
  resource_group_name      = data.azurerm_resource_group.resourcegroup[each.key].name
  location                 = data.azurerm_resource_group.resourcegroup[each.key].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "azurerm_storage_container" "tfstate_container" {
  for_each              = var.storage_accounts
  name                  = "kioncontainer"
  container_access_type = "private"
  storage_account_name  = each.value.storage_account_name

}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.storage_accounts
  name                = each.value.virtual_network_name
  address_space       = each.value.virtual_network_address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.storage_accounts
  depends_on           = [azurerm_virtual_network.vnet]
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.subnet_address_prefixes
}

resource "azurerm_private_dns_zone" "zone-id" {
  for_each            = var.storage_accounts
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.resourcegroup[each.key].name
}

resource "azurerm_private_endpoint" "pe" {
  for_each            = var.storage_accounts
  depends_on          = [azurerm_subnet.subnet]
  name                = "kion-endpoint"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = azurerm_subnet.subnet[each.key].id

  private_service_connection {
    name                           = "kion-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.stg_account[each.key].id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "kion-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.zone-id[each.key].id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link" {
  for_each = var.storage_accounts

  name                  = each.value.virtual_network_link_name
  resource_group_name   = data.azurerm_resource_group.resourcegroup[each.key].name
  private_dns_zone_name = azurerm_private_dns_zone.zone-id[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet[each.key].id
}
