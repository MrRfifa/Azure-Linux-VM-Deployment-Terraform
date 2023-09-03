
# Creating a subnet
resource "azurerm_subnet" "myapp-subnet" {
  name                 = "${var.env_prefix}-subnet-1"
  address_prefixes     = [var.subnet_cidr_block]
  resource_group_name  = var.res_grp_name
  virtual_network_name = var.vnet_name
}

# Creating a route table
resource "azurerm_route_table" "myapp-route-table" {
  name                          = "${var.env_prefix}-rtb"
  location                      = var.res_grp_location
  resource_group_name           = var.res_grp_name
  disable_bgp_route_propagation = false

  route {
    name           = "${var.env_prefix}-route1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

# Associate the route table with the subnet
resource "azurerm_subnet_route_table_association" "myapp-rt-association" {
  subnet_id      = azurerm_subnet.myapp-subnet.id
  route_table_id = azurerm_route_table.myapp-route-table.id
}

# Create a public IP address
resource "azurerm_public_ip" "myapp-public-ip" {
  name                = "${var.env_prefix}-public-ip"
  location            = var.res_grp_location
  resource_group_name = var.res_grp_name
  allocation_method   = "Static"
}
