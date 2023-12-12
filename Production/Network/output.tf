#Outputs to show vpc, public and private subnet IDs for our network.
output "public_subnet_ids" {
  value = module.vpc-Prod.public_subnet_id
}
output "private_subnet_ids" {
  value = module.vpc-Prod.private_subnet_id
}
output "vpc_id" {
  value = module.vpc-Prod.vpc_id
}