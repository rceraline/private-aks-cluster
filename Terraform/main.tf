terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.25.0"
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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-pvaks-cac"
  location = "canadacentral"
}

resource "azurerm_private_dns_zone" "mydomain" {
  name                = "mydomain.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mydomain" {
  name                  = "pdznl-mydomain-cac-001"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.mydomain.name
  virtual_network_id    = azurerm_virtual_network.vnet_hub.id
}

resource "azurerm_private_dns_a_record" "simple-webapp" {
  name                = "simple-webapp"
  zone_name           = azurerm_private_dns_zone.mydomain.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = ["10.1.0.4"]
}
