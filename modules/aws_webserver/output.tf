# Output variables
output "public_ips" {
  value = aws_instance.publicAmazonVM[*].public_ip
}

output "private_ips" {
  value = aws_instance.privateAmazonVM[*].private_ip
}

