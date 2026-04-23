module "resource_group" {
  source          = "../../module/azurerm_resource_group"
  resource_groups = var.resource_groups
}


module "vnet" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../module/azurerm_subnet"
  subnets    = var.subnets
}

module "storage" {
  depends_on       = [module.resource_group, module.vnet, module.subnet]
  source           = "../../module/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "loganalysis" {
  depends_on              = [module.resource_group]
  source                  = "../../module/log_analysis_workspace"
  log_analytics_workspace = var.log_analytics_workspace
}

module "acr_aks" {

  depends_on = [module.storage,module.loganalysis]
  source     = "../../module/azurerm_container_registry"
  acr        = var.acr
}


module "keyvault" {
  depends_on = [module.storage, module.subnet]
  source     = "../../module/azurerm_keyvoult"
  keyvault   = var.keyvault
}

module "server" {
  depends_on = [module.storage, module.subnet]
  source     = "../../module/azurerm_sql_server"
  servers    = var.servers
}



