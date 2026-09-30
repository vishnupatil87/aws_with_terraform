terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-july-batch-fctp" # this must be your s3 bucket name
    key    = "compute/fctp/dev/Day-03/terraform.tfstate"
    region = "ap-south-1"
  }
}
