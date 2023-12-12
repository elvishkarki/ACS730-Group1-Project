#Add variables
variable "default_tags" {
  default = {
    "Owner" = "Prason"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

#Add variables
variable "prefix" {
  default     = "Group1-ACS730"
  type        = string
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "public_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "Public Subnet CIDRs"
}
# Provision private subnets in custom VPC
variable "private_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "Public Subnet CIDRs"
}

# VPC CIDR range
variable "vpc_cidr" {
  default     = ""
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = ""
  type        = string
  description = "Deployment Environment"
}



