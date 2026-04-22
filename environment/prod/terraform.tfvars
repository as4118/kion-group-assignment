rgs = {
  rg1 = {
    resource_group_name = "dev-resource-group"
    location            = "centralindia"
  }
}

storage = {
  "stg1" = {
    storage_account_name = "storageaccount12345sp"
    resource_group_name  = "dev-resource-group"
    location             = "centralindia"
  }
}
vnets = {
  "vnet1" = {
    virtual_network_name = "dev-vnet"
    address_space        = ["10.0.0.0/16"]
    location             = "centralindia"
    resource_group_name  = "dev-resource-group"
  }

}

subnets = {
  "sub1" = {
    subnet_name          = "dev-frontend-sub"
    resource_group_name  = "dev-resource-group"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  "sub2" = {
    subnet_name          = "dev-backend-sub"
    resource_group_name  = "dev-resource-group"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

public_ip = {
  "pip1" = {
    public_ip_name      = "dev-frontend-pip"
    resource_group_name = "dev-resource-group"
    location            = "centralindia"
  }
  "pip2" = {
    public_ip_name      = "dev-backend-pip"
    resource_group_name = "dev-resource-group"
    location            = "centralindia"
  }
}

vm = {
  "vm1" = {

    vm_name                         = "dev-frontend-vm"
    resource_group_name             = "dev-resource-group"
    location                        = "centralindia"
    size                            = "Standard_F2"
    virtual_network_name            = "dev-vnet"
    subnet_name                     = "dev-frontend-sub"
    nic_name                        = "dev-nic-1"
    key_vault_name                  = "devkey123neelam"
    public_ip_name                  = "dev-frontend-pip"
    disable_password_authentication = false
    custom_data                     = "nginx.sh"
    ip_configuration = {
      "ipconfig1" = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
  vm2 = {
    vm_name                         = "dev-backend-vm"
    resource_group_name             = "dev-resource-group"
    location                        = "centralindia"
    size                            = "Standard_F2"
    virtual_network_name            = "dev-vnet"
    subnet_name                     = "dev-backend-sub"
    nic_name                        = "dev-nic-2"
    key_vault_name                  = "devkey123neelam"
    public_ip_name                  = "dev-backend-pip"
    disable_password_authentication = false
    custom_data                     = "nginx.sh"
    ip_configuration = {
      "ipconfig1" = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}


keyvault = {
  "kv1" = {
    key_vault_name      = "devkey123neelam"
    location            = "centralindia"
    resource_group_name = "dev-resource-group"
  }
}

servers = {
  "server1" = {
    server_name                  = "dev-server-ajaynewserver"
    resource_group_name          = "dev-resource-group"
    location                     = "centralindia"
    administrator_login          = "Devopsadmin"
    administrator_login_password = "Ajju!!!@@@1991"
    databases_name               = "dev-database-001"
  }
}
