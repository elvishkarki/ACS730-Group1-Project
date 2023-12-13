
provider "aws" {
  region = "us-east-1"
}

#Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


#Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}
# Define tags locally
locals {
  default_tags      = merge(var.default_tags, { "env" = var.env })
  ami_tag           = data.aws_ami.latest_amazon_linux.id
}

# VM1 and VM2 for private subnet 
resource "aws_instance" "privateAmazonVM" {
  ami                         = local.ami_tag
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  count                       = length(var.private_subnet_ids)
  subnet_id                   = var.private_subnet_ids[count.index]
  security_groups             = [aws_security_group.web_sg.id]
  root_block_device {
    encrypted = var.env == "test" ? true : false
  }
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Private-Amazon-Linux-${count.index}"
    }
  )
}

#BastionVM for public subnet-2
resource "aws_instance" "publicAmazonVM" {
  ami                         = local.ami_tag
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  count                       = length(var.public_subnet_ids)
  subnet_id                   = var.public_subnet_ids[count.index]
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data                   = count.index < 2 ? templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env)
    }
  ) : ""
  root_block_device {
    encrypted = var.env == "test" ? true : false
  }
  tags = count.index >= 2 ? (merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Vanilla-Amazon-Linux-${count.index}"
    }
  )) : merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux-${count.index}"
    })
}
#Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = var.prefix
  public_key = file("${var.SKey}.pub")
}

