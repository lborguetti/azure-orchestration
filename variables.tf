variable "env" {
  description = "environment to orchestrate"
}

variable "location" {
  description = "region where the resources should exist"
}

variable "address_space" {
  description = "address space list to the virtual network"
  type        = "list"
}

variable "cargo_subnet_address_prefix" {
  description = "cargo address prefix to the subnet"
}

variable "platform_fault_domain_count" {
  description = "number of update domains"
}

variable "platform_update_domain_count" {
  description = "number of fault domains"
}
