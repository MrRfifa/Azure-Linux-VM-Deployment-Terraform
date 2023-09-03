variable "vn_cidr_block" {
  description = "CIDR block for the virtual netwoork"
  type        = string
}

variable "res_grp_name" {
  type        = string
}

variable "res_grp_location" {
  type        = string
}


variable "env_prefix" {
  description = "Prefix for naming Azure resources"
  type        = string
}

variable "vm_credentials" {
  description = "Credentials for the Azure Virtual Machine"
  type = object({
    username          = string
    ssh_file_location = string
  })
}

variable "subnet_id" {
  type        = string
}

variable "public_ip_id" {
  type        = string
}
