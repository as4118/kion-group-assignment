variable "servers" {
  description = "Map of MSSQL servers configuration"
  type = map(object({
    server_name         = string
    resource_group_name = string
    location            = string
    key_vault_name      = string
    administrator_login = string
    databases_name      = string
  }))
}