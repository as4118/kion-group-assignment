terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "kion-rg-dev"
  #   storage_account_name = "kionstgaccount1"
  #   container_name       = "kioncontainer"
  #   key                  = "kion.ttstate"
  # tennant_id = "72f988bf-86f1-4111-9d98-000d3adfba00"
  # }

}
provider "azurerm" {
  features {}
}
