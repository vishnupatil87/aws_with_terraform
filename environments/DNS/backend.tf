terraform {
  backend "s3" {
    bucket = "new-terraform-july" # this must be your s3 bucket name
    key    = "global/dns/vishji.in/terraform.tfstate"
    region = "ap-south-1"
  }
}
