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

variable "cargo_platform_fault_domain_count" {
  description = "cargo number of update domains"
}

variable "cargo_platform_update_domain_count" {
  description = "cargo number of fault domains"
}

variable "cargo_subnet_address_prefix" {
  description = "cargo address prefix to the subnet"
}

variable "cargo_virtual_machine_count" {
  description = "cargo number of virtual machines to launch"
}
