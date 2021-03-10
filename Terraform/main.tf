terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance
# cidr_block    = "10.0.0.0/16"

  tags = {
    Name = "EC2 Instance"
    Environment = "development"
  }
}


