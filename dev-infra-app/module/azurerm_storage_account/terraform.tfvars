storage_accounts = {
  "stgaccount1" = {
    name                          = "kionstgaccount1"
    resource_group_name           = "kion-rg-dev"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    virtual_network_link_name     = "kion-vnet-link"
    virtual_network_name          = "kion-vnet-stgaccount1"
    virtual_network_address_space = ["10.0.0.0/16"]
    subnet_name                   = "kion-subnet-stgaccount1"
    subnet_address_prefixes       = ["10.0.1.0/24"]
  }
}