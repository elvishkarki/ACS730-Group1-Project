terraform {
  backend "s3" {
    bucket = "staging-s3-acsgroup1"
    key    = "staging-webserver/terraform.tfstate"
    region = "us-east-1"
  }
}