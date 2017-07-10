variable "env" {
  description = "environment to orchestrate"
}

variable "location" {
  description = "region where the resources should exist"
}

variable "subnet_address_prefix" {
  description = "address prefix to the subnet"
}

variable "platform_fault_domain_count" {
  description = "number of update domains"
}

variable "platform_update_domain_count" {
  description = "number of fault domains"
}

variable "trusted_ip" {
  description = "trusted ip to allow ssh"
}

variable "virtual_network_name" {
  description = "virtual network name"
}

variable "virtual_network_resource_group_name" {
  description = "resource group name of the virtual network"
}

variable "virtual_machine_admin_password" {
  description = "password to add to the virtual machine"
}

variable "virtual_machine_admin_username" {
  description = "username to add to the virtual machine"
}

variable "virtual_machine_count" {
  description = "number of virtual machines to launch"
}

variable "virtual_machine_size" {
  description = "size of virtual machines to launch"
}
