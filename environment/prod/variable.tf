variable "rgs" {
  type = map(object(
    {
      resource_group_name = string
      location            = string
    }
  ))
}

variable "storage" {
  type = map(object({
    storage_account_name = string
    resource_group_name  = string
    location             = string
  }))
}

variable "vnets" {
  type = map(object(
    {
      virtual_network_name = string
      address_space        = list(string)
      location             = string
      resource_group_name  = string
    }
  ))
}

variable "subnets" {
  type = map(object(
    {
      subnet_name          = string
      resource_group_name  = string
      virtual_network_name = string
      address_prefixes     = list(string)
    }
  ))
}

variable "vm" {
  type = map(object(
    {
      vm_name                         = string
      resource_group_name             = string
      location                        = string
      size                            = string
      virtual_network_name            = string
      subnet_name                     = string
      nic_name                        = string
      key_vault_name                  = string
      public_ip_name                  = string
      custom_data                     = string
      disable_password_authentication = bool
      ip_configuration = map(object({
        name                          = string
        private_ip_address_allocation = string
      }))
    }
  ))
}

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

variable "keyvault" {
  type = map(object({
    key_vault_name      = string
    location            = string
    resource_group_name = string
  }))
}

variable "public_ip" {
  type = map(object({
    public_ip_name      = string
    resource_group_name = string
    location            = string
  }))
}
