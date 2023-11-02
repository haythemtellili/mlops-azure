variable "resource_group" {
  default = "aml-terraform-demo"
}

variable "environment" {
  type    = string
}

variable "workspace_display_name" {
  default = "aml-terraform-demo"
}

variable "location" {
  default = "Poland Central"
}

variable "prefix" {
  type = string
  default = "aml"
}

resource "random_string" "postfix" {
  length = 6
  special = false
  upper = false
}

variable "cluster_name" {
  type = string
  default = "cpu-cluster"
}

variable "compute_name" {
  type = string
  default = "haythem-compute"
}
