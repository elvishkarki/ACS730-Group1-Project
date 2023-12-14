# Output variables to show VM public and private ip addressess
output "public_ips_instances" {
  value = module.vpc-Prod-server.public_ips[*]
}

output "private_ips_instances" {
  value = module.vpc-Prod-server.private_ips[*]
}
