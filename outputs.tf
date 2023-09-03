output "vm_ip" {
  value = module.myapp-subnet.public_ip_object.ip_address
}
