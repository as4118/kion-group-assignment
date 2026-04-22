module "subnet" {
  source  = "../../module/azurerm_subnet"
  subnets = var.subnets
}

module "vnet" {
  source = "../../module/azurerm_virtual_network"
  vnets  = var.vnets
}

module "loganalysis" {
  source                  = "../../module/log_analysis_workspace"
  log_analytics_workspace = var.log_analytics_workspace
}
module "storage" {
  source           = "../../module/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "acr_aks" {
  depends_on = [module.storage]
  source     = "../../module/azurerm_container_registry"
  acr        = var.acr
}


module "keyvault" {
  depends_on = [module.storage]
  source     = "../../module/azurerm_keyvoult"
  keyvault   = var.keyvault
}



module "server" {
  depends_on = [module.storage]
  source     = "../../module/azurerm_sql_server"
  servers    = var.servers
}




