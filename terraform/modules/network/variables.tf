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
