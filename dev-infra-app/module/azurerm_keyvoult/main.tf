data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  for_each = var.keyvault

  name                        = each.value.key_vault_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  rbac_authorization_enabled  = true

}

resource "azurerm_user_assigned_identity" "uami" {
  depends_on = [ azurerm_key_vault.kv ]

  for_each = var.keyvault
  location            = each.value.location
  name                = each.value.user_assigned_identity_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_role_assignment" "rollassinment" {
  depends_on = [ azurerm_user_assigned_identity.uami ]

  for_each = var.keyvault
  scope                = azurerm_key_vault.kv[each.key].id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.uami[each.key].principal_id
}

resource "azurerm_role_assignment" "kv_admin_user" {
  for_each = var.keyvault
  
  scope                = azurerm_key_vault.kv[each.key].id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}



