locals {

  common_tags = {

    Environment = var.environment

    Project = var.project_name

    ManagedBy = var.managed_by
  }
}

#################################################
# ECR KMS KEY
#################################################

module "platform_kms" {

  source = "../../../../modules/security/kms"

  environment = var.environment

  key_alias = "platform"

  description = "Platform KMS Key"

  common_tags = local.common_tags
}