terraform {
  backend "s3" {
    bucket = "group1-project"
    key    = "prod-webserver/terraform.tfstate"
    region = "us-east-1"
  }
}