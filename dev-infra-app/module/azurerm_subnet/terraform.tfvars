subnets = {
  "sub1" = {
    subnet_name          = "dev-frontend-sub"
    resource_group_name  = "dev-resource-group1"
    virtual_network_name = "dev-vnet"
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
    resource_group_name  = "dev-resource-group1"
    virtual_network_name = "dev-vnet"
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
