#############################################################
# RDS DB Subnet Group
#
# Creates a dedicated DB subnet group using existing
# private subnets.
#
# AWS requires at least two subnets in different AZs.
#############################################################

resource "aws_db_subnet_group" "this" {

  name = "${local.name_prefix}-db-subnet-group"

  description = "DB Subnet Group for ${local.db_identifier}"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-subnet-group"
    }
  )

}