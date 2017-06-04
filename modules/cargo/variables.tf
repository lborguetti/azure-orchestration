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

variable "virtual_network_name" {
  description = "virtual network name"
}

variable "virtual_network_resource_group_name" {
  description = "resource group name of the virtual network"
}
