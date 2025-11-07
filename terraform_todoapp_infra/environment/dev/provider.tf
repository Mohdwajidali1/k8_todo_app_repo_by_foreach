terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "Rg_storage"
  #   storage_account_name = "strgbeckend"
  #   container_name       = "beckendcontainer"
  #   key                  = "terraform.tfstate"

  # }
}
provider "azurerm" {
  features {}
  subscription_id = "1b868269-c6fa-465c-b34a-76f5e59036b7"
  tenant_id = "41f65365-4083-4b66-9451-eb3d952f7482"

}
