terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.67.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }

  tenant_id = "fc6028c4-a2cf-4768-854f-f43625fcbd9a"

}

resource "azurerm_resource_group" "chetan-qa" {
  name     = "chetan-qa"
  location = "West Europe"
}

resource "azurerm_resource_group" "chetan-dev" {
  name     = "chetan-dev"
  location = "West Europe"
}

resource "azurerm_resource_group" "chetan-eu" {
  name     = "chetan-estus"
  location = "East US"
}
