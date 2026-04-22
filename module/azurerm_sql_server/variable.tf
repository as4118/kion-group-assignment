variable "servers" {
  type = map(object({
    server_name                  = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    databases_name               = string
  }))
}
