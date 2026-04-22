terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }

backend "azurerm" {
  resource_group_name="rg-dev-resourcegroup"
  storage_account_name="storageaccount12345sp"
  container_name="serviceconnection"
  key = "ajay.ttstate"
}
}
provider "azurerm" {
  features {}
  subscription_id = "7ccb66b8-87a3-4a6a-9f86-aa9aaad3bf02"
}