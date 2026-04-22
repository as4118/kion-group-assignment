
module "resources_group" {
    source  = "../../module/azurerm_resource"
    rgs     = var.rgs
}

module "storage" {
  source = "../../module/azurerm_storage_account"
  storage = var.storage
}

module "vnet" {
  depends_on = [ module.resources_group ]
  source  = "../../module/azurerm_virtual_network"
  vnets   = var.vnets
}

module "subnet" {
  depends_on = [ module.vnet ]
  source     = "../../module/azurerm_subnet"
  subnets    = var.subnets
  
}

module "keyvault" {
  depends_on = [ module.resources_group ]
  source = "../../module/azurerm_keyvoult"
  keyvault = var.keyvault
}

module "pip" {
  depends_on = [ module.resources_group,module.vnet , module.subnet ]
  source = "../../module/azurerm_public_ip"
  public_ip = var.public_ip
}

module "azurerm_compute" {
  depends_on = [module.subnet, module.keyvault,module.pip]
  source     = "../../module/azurerm_compute"
  vm         = var.vm
}

module "server" {
  depends_on = [ module.resources_group , module.vnet]
  source = "../../module/azurerm_sql_server"
  servers = var.servers
}




