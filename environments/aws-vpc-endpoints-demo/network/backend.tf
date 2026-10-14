terraform {
  backend "s3" {

    bucket = "new-terraform-july" # this must be your s3 bucket name
    key    = "network/fctp/dev/vpc-endpoints-demo/terraform.tfstate"
    region = "ap-south-1"
  }
}