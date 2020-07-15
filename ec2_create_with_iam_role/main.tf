terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

#### backend configuration #####
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-infra-automation"
    region         = "us-east-2"
    key            = "terraform-state-files/ec2-iam-role.tfstate"
    dynamodb_table = "terraform-state-locking"
  }
}

#### resources provision #########

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-05c0ec6b9db79b820"]
  subnet_id              = "subnet-b632cffa"
  tags = {
    Terraform = "true"
    product   = "jenkins"
  }
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  key_name             = "jenkins"
}

