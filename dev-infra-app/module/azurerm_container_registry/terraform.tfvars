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