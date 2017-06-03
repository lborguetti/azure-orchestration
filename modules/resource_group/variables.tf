variable "env" {
  description = "environment to orchestrate"
  default     = "dev"
}

variable "location" {
  description = "region where the resources should exist"
  default     = "eastus"
}

variable "name_prefix" {
  description = "unique part of the name to give to resources"
}
