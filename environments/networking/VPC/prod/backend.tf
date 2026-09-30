terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-july-batch-fctp" # this must be your s3 bucket name
    key    = "Networking/fctp/prod/vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}
