variable "acr" {
  description = "Map of ACR and AKS configurations"

  type = map(object({
    acr_name                      = string
    aks_name                      = string
    resource_group_name           = string
    location                      = string
    dns_prefix                    = string
    node_count                    = number
    vm_size                       = string
    user_assigned_identity_name   = string

    tags = map(string)
  }))
}