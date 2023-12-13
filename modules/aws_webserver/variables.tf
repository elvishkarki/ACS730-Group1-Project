# Instance type
variable "instance_type" {
  default = {
    "prod"        = "t2.micro"
    "test"        = "t2.micro"
    "nonProd"     = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

# Default tags
variable "default_tags" {
  default = {
    "Owner" = "ACS730-Group1-Project"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Prefix to identify resources
variable "prefix" {
  default     = "Group1"
  type        = string
  description = "Name prefix"
}

#Custom VPC ID vpc_id
variable "vpc_id" {
  default     = ""
  type        = string
  description = "VPC ID"
}

# public subnets in custom VPC
variable "public_subnet_ids" {
  type        = list(string)
  description = "Public Subnet CIDRs"
}
# private subnets in custom VPC
variable "private_subnet_ids" {
  type        = list(string)
  description = "Private Subnet CIDRs"
}

# Custom SSH key of each environment
variable "SKey" {
  default     = ""
  type        = string
  description = "Name prefix"
}

# Variable to signal the current environment 
variable "env" {
  default     = ""
  type        = string
  description = "Deployment Environment"
}
