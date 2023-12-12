
provider "aws" {
  region = "us-east-1"
}

# Step 12 - Data source for AMI id
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
resource "aws_instance" "amazonVM" {
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
      "Name" = "${var.prefix}-Amazon-Linux-${count.index}"
    }
  )
}

#BastionVM for public subnet-2
resource "aws_instance" "amazonBastionVM" {
  count                       = var.env == "nonProd" ? 1 : 0
  ami                         = local.ami_tag
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = var.public_subnet_ids[1]
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data                   = templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env)
    }
  )
  root_block_device {
    encrypted = var.env == "test" ? true : false
  }
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux-Bastion"
    }
  )
}
#Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = var.prefix
  public_key = file("${var.SKey}.pub")
}


# Security Group
resource "aws_security_group" "web_sg" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-SG"
    }
  )
}