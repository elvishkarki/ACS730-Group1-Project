
# Module to deploy basic networking for nonProd(development) environment
module "vpc-Prod" {
  source              = "../../../Group1-ACS730-FinalProject/Production/modules/aws_network"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_cidr_blocks  = var.public_subnet_cidrs
  private_cidr_blocks = var.private_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
}
