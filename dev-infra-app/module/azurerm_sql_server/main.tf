
data "azurerm_key_vault" "kv" {
  for_each            = var.servers
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_key_vault_secret" "sql_admin_password" {
  for_each     = var.servers
  name         = "${each.key}-sql-admin-password"
  value        = "ChangeMe@123"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id

  lifecycle {
    ignore_changes = [value]
  }
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  for_each     = var.servers
  name         = "${each.key}-sql-admin-password"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


resource "azurerm_mssql_server" "server" {
  for_each = var.servers

  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  version             = "12.0"

  administrator_login = each.value.administrator_login


  administrator_login_password = data.azurerm_key_vault_secret.sql_admin_password[each.key].value

  minimum_tls_version = "1.2"
}

resource "azurerm_mssql_database" "db" {
  for_each = var.servers

  name      = each.value.databases_name
  server_id = azurerm_mssql_server.server[each.key].id

  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
}