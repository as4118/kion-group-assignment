variable "resource_groups" {
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = map(string)
  }))
}

variable "acr" {
  description = "ACR + AKS configuration"
  type = map(object({
    acr_name                     = string
    aks_name                     = string
    resource_group_name          = string
    location                     = string
    dns_prefix                   = string
    node_count                   = number
    vm_size                      = string
    user_assigned_identity_name  = string
    kubernetes_version           = string
    min_count                    = number
    max_count                    = number
    log_analytics_workspace_name = string

    tags = map(string)
  }))
}

variable "storage_accounts" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    account_tier                  = string
    account_replication_type      = string
    virtual_network_link_name     = string
    virtual_network_name          = string
    virtual_network_address_space = list(string)
    subnet_name                   = string
    subnet_address_prefixes       = list(string)
    storage_account_name          = string
  }))
}

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


variable "keyvault" {

  type = map(object(
    {
      key_vault_name              = string
      location                    = string
      resource_group_name         = string
      user_assigned_identity_name = string
    }
  ))
}



variable "subnets" {
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    nsg_name             = string
    location             = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "log_analytics_workspace" {
  type = map(object({
    workspace_name      = string
    location            = string
    resource_group_name = string
  }))

}

variable "vnets" {
  type = map(object({
    virtual_network_name = string
    address_space        = list(string)
    location             = string
    resource_group_name  = string
  }))
}
