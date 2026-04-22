resource "azurerm_mssql_server" "server" {
  for_each = var.servers

  name                         = each.value.server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  minimum_tls_version          = "1.2"
}


resource "azurerm_mssql_database" "sqldatabase" {
for_each = var.servers
depends_on = [ azurerm_mssql_server.server ]

  name         = each.value.databases_name
  server_id    = azurerm_mssql_server.server[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}

