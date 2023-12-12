# Output variables to show VM public and private ip addressess
output "bastion_ip" {
  value = module.vpc-Prod-server.public_ips[*]
}

output "private_ip" {
  value = module.vpc-Prod-server.private_ips[*]
}
