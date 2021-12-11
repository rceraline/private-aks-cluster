terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  backend "azurerm" {
    subscription_id      = "{subscription ID}"
    resource_group_name  = "rg-tfstate-cac"
    storage_account_name = "satfstatecac"
    container_name       = "state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "{subscription ID}"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-pvaks-cac"
  location = "canadacentral"
}
