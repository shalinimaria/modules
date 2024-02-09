variable "location" {
  description = "The Azure region where the resources will be provisioned."
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create resources."
  default     = "myResourceGroup"
}

variable "vm_name" {
  description = "The name of the virtual machine."
  default     = "myVM"
}

variable "vm_size" {
  description = "The size of the virtual machine."
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The username for the virtual machine."
  default     = "azureuser"
}

variable "admin_password" {
  description = "The password for the virtual machine."
  default     = "Password123!"
}

#variable "subnet_id" {
 # description = "The ID of the subnet to attach the virtual machine to."
 # default = ["10.0.2.0/24"]
#}