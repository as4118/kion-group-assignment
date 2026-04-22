acr = {
  dev = {
    acr_name                    = "kiondevacr12345"
    aks_name                    = "kion-dev-aks-cluster"
    resource_group_name         = "kion-rg-dev"
    location                    = "Central India"
    dns_prefix                  = "devaks"
    node_count                  = 2
    vm_size                     = "standard_a4_v2"
    user_assigned_identity_name = "kion-dev-uami1"

    tags = {
      env  = "dev"
      team = "kion-devops"
    }
  }
}
