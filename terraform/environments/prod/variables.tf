variable "resource_group" {
  default = "aml-terraform-demo"
}

variable "environmentIdentifier" {
  type    = string
}

variable "workloadIdentifier" {
  type = string
}

variable "workspace_display_name" {
  default = "aml-terraform-demo"
}

variable "location" {
  default = "Poland Central"
}

variable "cluster_name" {
  type = string
  default = "cpu-cluster"
}

variable "compute_name" {
  type = string
  default = "haythem-compute"
}