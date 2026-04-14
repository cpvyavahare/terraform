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

resource "azurerm_resource_group" "ex-depend" {
  name     = "chetan_ex-depend_test"
  location = "Central India"
}

resource "azurerm_storage_account" "ex_depend_storage" {
depends_on = [ azurerm_resource_group.ex-depend ]
  name                     = "chetanexplicitstorage"
  resource_group_name      = "chetan_ex-depend_test"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}