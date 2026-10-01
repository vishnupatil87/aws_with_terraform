data "terraform_remote_state" "vpc_backend" {
 backend = "s3"

  config = {
    bucket = "new-terraform-july" # this must be your s3 bucket name
    key    = "Networking/fctp/dev/vpc/terraform.tfstate"
    region = "ap-south-1"

}
}