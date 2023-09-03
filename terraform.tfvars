vn_cidr_block     = "10.0.0.0/16" # For example 10.0.0.0/16
subnet_cidr_block = "10.0.10.0/24"          #For example 10.0.10.0/24
env_prefix        = "dev"
vm_credentials = {
  username : "any_username", # I used azureuser
  ssh_file_location : "C:/Users/anoua/.ssh/test_vm/my_ssh_key.pub"
}

private_key_location="C:/Users/anoua/.ssh/test_vm/my_ssh_key"
