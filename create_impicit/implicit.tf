terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "depend" {
  name     = "chetan_depend_test"
  location = "West Europe"
}

resource "azurerm_storage_account" "depend_storage" {
  name                     = "chetanstorage11"
  resource_group_name      = azurerm_resource_group.depend.name
  location                 = azurerm_resource_group.depend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}