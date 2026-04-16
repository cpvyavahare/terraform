terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
features {
  
}
}

resource "azurerm_resource_group" "homework" {
  name     = "hw11"
  location = "West Europe"
}

resource "azurerm_storage_account" "homestorage" {
  name                     = "hwstorage112"
  resource_group_name      = azurerm_resource_group.homework.name
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

