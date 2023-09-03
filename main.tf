module "myapp-subnet" {
  source            = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  env_prefix        = var.env_prefix
  res_grp_name      = azurerm_resource_group.myapp-res-grp.name
  res_grp_location  = azurerm_resource_group.myapp-res-grp.location
  vnet_name         = module.myapp-webserver.vnet_object.name
}

module "myapp-webserver" {
  source           = "./modules/webserver"
  env_prefix       = var.env_prefix
  vn_cidr_block    = var.vn_cidr_block
  public_ip_id     = module.myapp-subnet.public_ip_object.id
  res_grp_location = azurerm_resource_group.myapp-res-grp.location
  res_grp_name     = azurerm_resource_group.myapp-res-grp.name
  subnet_id        = module.myapp-subnet.subnet_object.id
  vm_credentials   = var.vm_credentials

}

# Creating a resource group
resource "azurerm_resource_group" "myapp-res-grp" {
  name     = "${var.env_prefix}_res_grp"
  location = "West Europe"
}
