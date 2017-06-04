variable "env" {
  description = "environment to orchestrate"
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
