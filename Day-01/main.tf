terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "example" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id = "subnet-08b75eb08aac8a861"

  tags = {
    Name = "tf_ec2_instance"
  }
}

