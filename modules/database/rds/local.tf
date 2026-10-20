#############################################################
# Local Values
#############################################################

locals {

  ###########################################################
  # Resource Naming
  ###########################################################

  name_prefix = "${var.project_name}-${var.environment}"

  db_identifier = "${local.name_prefix}-${var.db_identifier}"

  ###########################################################
  # Common Tags
  ###########################################################

  common_tags = merge(
    {
      Name        = local.db_identifier
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "RDS"
    },
    var.tags
  )

}