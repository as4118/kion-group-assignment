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