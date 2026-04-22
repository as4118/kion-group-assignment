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


