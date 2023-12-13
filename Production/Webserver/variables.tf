
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


# Variable to signal the current environment 
variable "env" {
  default     = "Production"
  type        = string
  description = "Deployment Environment"
}

#SSH key for all the VMs
variable "SKey" {
  default     = "/home/ec2-user/.ssh/ACS730-Group1-Key"
  type        = string
  description = "VM SSH key"
}