variable "subnet_cidr_block" {
  description = "CIDR block for the Azure Subnet"
  type        = string
}

variable "res_grp_name" {
  type        = string
}

variable "res_grp_location" {
  type        = string
}


variable "vnet_name" {
  type        = string
}

variable "env_prefix" {
  description = "Prefix for naming Azure resources"
  type        = string
}