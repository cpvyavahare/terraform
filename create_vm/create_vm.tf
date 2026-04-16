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

resource "azurerm_resource_group" "chetan-vm22" {
  name     = "chetan-vm22-resources"
  location = "Central India"
}

resource "azurerm_virtual_network" "chetan-vm22" {
  name                = "chetan-vm22-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.chetan-vm22.location
  resource_group_name = azurerm_resource_group.chetan-vm22.name
}

resource "azurerm_subnet" "chetan-vm22" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.chetan-vm22.name
  virtual_network_name = azurerm_virtual_network.chetan-vm22.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "chetan-vm22" {
  name                = "chetan-vm22-nic"
  location            = azurerm_resource_group.chetan-vm22.location
  resource_group_name = azurerm_resource_group.chetan-vm22.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.chetan-vm22.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "chetan-vm22-nsg" {
  name                = "nsg22"
  location            = azurerm_resource_group.chetan-vm22.location
  resource_group_name = azurerm_resource_group.chetan-vm22.name
  security_rule {
    name                       = "pushpatherule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = [22]
        source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "chetan-vm22" {
  name                = "chetan-vm22-machine"
  disable_password_authentication = "false"
  resource_group_name = azurerm_resource_group.chetan-vm22.name
  location            = azurerm_resource_group.chetan-vm22.location
  size                = "Standard_D4s_v3"
  admin_username      = "adminuser"
  admin_password      = "Pune@123123123"
  network_interface_ids = [
    azurerm_network_interface.chetan-vm22.id,
  ]

  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "16.04.202109281"
  }
}