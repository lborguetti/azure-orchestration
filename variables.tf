variable "env" {
  description = "environment to orchestrate"
}

variable "address_space" {
  description = "address space list to the virtual network"
  type        = "list"
}

variable "location" {
  description = "region where the resources should exist"
}

variable "platform_fault_domain_count" {
  description = "number of update domains"
}

variable "platform_update_domain_count" {
  description = "number of fault domains"
}
