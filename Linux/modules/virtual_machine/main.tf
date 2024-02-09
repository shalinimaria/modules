terraform { 

  required_providers { 

    azurerm = { 

      source = "hashicorp/azurerm" 

      version = ">= 2.0" 

    } 

  } 

} 
resource "azurerm_resource_group" "example" { 
  name     = var.resource_group_name 
  location = var.location
} 
resource "azurerm_virtual_network" "example" { 
  name                = "example-network" 
  address_space       = ["10.0.0.0/16"] 
  location            = var.location
  resource_group_name = var.resource_group_name

} 
resource "azurerm_subnet" "example" { 
  name                 = "internal" 
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name 
  address_prefixes     = ["10.0.2.0/24"] 
}

resource "azurerm_public_ip" "example" {
  name                = "${var.vm_name}-public-ip"
 # location            = var.location
  location = azurerm_resource_group.example.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "example" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.vm_name}-nic-configuration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = var.vm_name
  disable_password_authentication = false
}

output "public_ip_address" {
  value = azurerm_public_ip.example.ip_address
}
