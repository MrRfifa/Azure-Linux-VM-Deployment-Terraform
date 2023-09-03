variable "vn_cidr_block" {
  description = "CIDR block for the Azure Virtual Network"
  type        = string
}
variable "subnet_cidr_block" {
  description = "CIDR block for the Azure Subnet"
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