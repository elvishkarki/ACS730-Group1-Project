
terraform {
  backend "s3" {
    bucket = "group1.1-project"               // Bucket where to SAVE Terraform State
    key    = "prod/network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                      // Region where bucket is created
  }
}



# module to deploy server from nonProd(development) environment
module "vpc-Prod-server" {
  source             = "../../../Group1-ACS730-FinalProject/modules/aws_webserver"
  env                = var.env
  vpc_id             = data.terraform_remote_state.subnets.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.subnets.outputs.private_subnet_ids
  public_subnet_ids  = data.terraform_remote_state.subnets.outputs.public_subnet_ids
  SKey               = var.SKey
  prefix             = var.prefix
  default_tags       = var.default_tags
}

