terraform {
  backend "s3" {
    bucket = "new-terraform-july" # this must be your s3 bucket name
    key    = "storage/fctp/acm/global/terraform.tfstate"
    region = "ap-south-1"
  }
}
