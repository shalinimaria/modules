terraform { 

  required_providers { 

    azurerm = { 

      source = "hashicorp/azurerm" 

      version = ">= 2.0" 

    } 

  } 

} 
provider "azurerm" {
  features {}
}

module "virtual_machine" {
  source  = "./modules/virtual_machine"
  
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  #subnet_id           = var.subnet_id
}
