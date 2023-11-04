variable "location" {
  description = "Azure region where the workspace should be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "name" {
  type = string
}