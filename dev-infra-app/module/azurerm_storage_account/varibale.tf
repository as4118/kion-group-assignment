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
  }))
}