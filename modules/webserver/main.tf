# Creating a virtual network
resource "azurerm_virtual_network" "myapp-vn" {
  name                = "${var.env_prefix}-vpc"
  address_space       = [var.vn_cidr_block]
  location            = var.res_grp_location
  resource_group_name = var.res_grp_name
}

# Create a network security group (NSG)
resource "azurerm_network_security_group" "myapp-nsg" {
  name                = "${var.env_prefix}-nsg"
  location            = var.res_grp_location
  resource_group_name = var.res_grp_name
  # Allow SSH (port 22) traffic
  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001 # Choose an appropriate priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  # Allow port 8080 traffic (HTTP)
  security_rule {
    name                       = "allow-8080"
    priority                   = 1002 # Choose an appropriate priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "myapp-net-int-sec-grp-association" {
  network_interface_id      = azurerm_network_interface.myapp-net-interface.id
  network_security_group_id = azurerm_network_security_group.myapp-nsg.id
}

resource "azurerm_network_interface" "myapp-net-interface" {
  name                = "${var.env_prefix}-nic"
  location            = var.res_grp_location
  resource_group_name = var.res_grp_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_linux_virtual_machine" "myapp-vm" {
  name                  = "${var.env_prefix}-machine"
  resource_group_name   = var.res_grp_name
  location              = var.res_grp_location
  size                  = "Standard_DS1_v2"
  admin_username        = var.vm_credentials.username
  network_interface_ids = [azurerm_network_interface.myapp-net-interface.id]

  # admin_password      = var.vm_credentials.password
  admin_ssh_key {
    username   = var.vm_credentials.username
    public_key = file(var.vm_credentials.ssh_file_location)
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  user_data = filebase64("docker.sh")
}
