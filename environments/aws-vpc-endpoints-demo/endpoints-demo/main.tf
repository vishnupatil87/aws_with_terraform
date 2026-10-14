#################################################
# SECURITY GROUP
#################################################

module "security_group" {

  source = "../../../modules/aws-vpc-s3-endpoints/security-group"

  environment = var.environment

  project_name = var.project_name

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  vpc_cidr = var.vpc_cidr
}

#################################################
# S3
#################################################

module "s3" {

  source = "../../../modules/aws-vpc-s3-endpoints/s3"

  environment = var.environment

  bucket_name = var.bucket_name
}

#################################################
# IAM
#################################################

module "iam" {

  source = "../../../modules/aws-vpc-s3-endpoints/iam"

  environment = var.environment

  bucket_arn = module.s3.bucket_arn


}

#################################################
# EC2
#################################################

module "ec2" {
  source = "../../../modules/aws-vpc-s3-endpoints/ec2"

  providers = {
    aws = aws
  }

  environment           = var.environment
  project_name          = var.project_name
  instance_type         = var.instance_type
  private_subnet_id     = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
  ec2_security_group_id = module.security_group.ec2_security_group_id
  instance_profile_name = module.iam.instance_profile_name

  depends_on = [
    module.iam
  ]
}