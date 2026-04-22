resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}


resource "azurerm_network_security_group" "nsg_frontend" {
  depends_on          = [azurerm_subnet.subnet]
  for_each            = var.subnets
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = try(each.value.security_rules, [])
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }

  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  depends_on                = [azurerm_network_security_group.nsg_frontend]
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg_frontend[each.key].id
}
