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
  name     = "hw21"
  location = "West Europe"
}

resource "azurerm_resource_group" "homework2" {
  name     = "hw22"
  location = "East US"
}

resource "azurerm_storage_account" "homestorage" {
    depends_on = [ azurerm_resource_group.homework ]
  name                     = "hwstorage113"
  resource_group_name      = "hw21"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "homestorage123" {

  name                     = "hwstorage114"
  resource_group_name      = azurerm_resource_group.homework.name
  location                 = azurerm_resource_group.homework.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "homestorage124" {

  name                     = "hwstorage115"
  resource_group_name      = azurerm_resource_group.homework.name
  location                 = azurerm_resource_group.homework2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



