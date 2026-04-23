resource_groups = {
  "rg1" = {
    resource_group_name = "kion-rg-dev"
    location            = "centralindia"
    tags = {
      environment = "dev"
      project     = "kion-group-assignment"
    }
  }
}

vnets = {
  "vnet1" = {
    virtual_network_name = "kion-vnet-stgaccount1"
    address_space        = ["10.0.0.0/16"]
    location             = "centralindia"
    resource_group_name  = "kion-rg-dev"
  }

}

subnets = {
  "sub1" = {
    subnet_name          = "dev-frontend-sub"
    resource_group_name  = "kion-rg-dev"
    virtual_network_name = "kion-vnet-stgaccount1"
    address_prefixes     = ["10.0.1.0/24"]
    location             = "centralindia"
    nsg_name             = "nsg-frontend"
    security_rules = [
      {
        name                       = "rule1-subnet1"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "*"
      },
      {
        name                       = "ssh-rule-subnet1"
        priority                   = 109
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

    ]
  }
  "sub2" = {
    subnet_name          = "dev-backend-sub"
    resource_group_name  = "kion-rg-dev"
    virtual_network_name = "kion-vnet-stgaccount1"
    address_prefixes     = ["10.0.2.0/24"]
    location             = "centralindia"
    nsg_name             = "nsg-backend"
    security_rules = [
      {
        name                       = "rule1-subnet2"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
      },
      {
        name                       = "ssh-rule-subnet2"
        priority                   = 109
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

acr = {
  dev = {
    acr_name                    = "kiondevacr12345"
    aks_name                    = "kion-dev-aks-cluster"
    resource_group_name         = "kion-rg-dev"
    location                    = "Central India"
    dns_prefix                  = "devaks"
    node_count                  = 2
    vm_size                     = "Standard_D4s_v3"
    user_assigned_identity_name = "kion-dev-uami1"
    kubernetes_version          = "1.29.0"
    min_count                   = 1
    max_count                   = 3

    log_analytics_workspace_name = "acctest-01"

    tags = {
      env  = "dev"
      team = "kion-devops"
    }
  }
}

storage_accounts = {
  "stgaccount1" = {
    name                          = "kionstgaccount1"
    resource_group_name           = "kion-rg-dev"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    virtual_network_link_name     = "kion-vnet-link"
    virtual_network_name          = "kion-vnet-stgaccount12"
    virtual_network_address_space = ["10.95.0.0/16"]
    subnet_name                   = "kion-subnet-stgaccount1"
    subnet_address_prefixes       = ["10.95.1.0/24"]
  }
}

keyvault = {
  "kv1" = {
    key_vault_name              = "kion-devkey12345"
    location                    = "centralindia"
    resource_group_name         = "kion-rg-dev"
    user_assigned_identity_name = "kion-dev-uami"
  }
}

servers = {
  server1 = {
    server_name         = "kion-dev-server-001"
    resource_group_name = "kion-rg-dev"
    location            = "centralindia"
    administrator_login = "Devopsadmin"
    databases_name      = "kion-dev-database-001"
    key_vault_name      = "kion-dev-kv-001"
  }
}


log_analytics_workspace = {
  "workspace" = {
    workspace_name      = "dev-log-analytics-workspace"
    location            = "centralindia"
    resource_group_name = "kion-rg-dev"
  }
}
