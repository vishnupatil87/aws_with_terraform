#############################################################
# CloudWatch Log Group
#############################################################

resource "aws_cloudwatch_log_group" "postgresql" {

  count = var.create_cloudwatch_log_group ? 1 : 0

  name = "/aws/rds/instance/${local.db_identifier}/postgresql"

  retention_in_days = var.cloudwatch_log_retention_in_days

  kms_key_id = var.kms_key_arn

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgresql-log-group"
    }
  )
}

#############################################################
# IAM Assume Role Policy
#############################################################

data "aws_iam_policy_document" "monitoring_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {

      type = "Service"

      identifiers = [
        "monitoring.rds.amazonaws.com"
      ]

    }

  }

}

#############################################################
# Enhanced Monitoring IAM Role
#############################################################

resource "aws_iam_role" "monitoring" {

  count = var.monitoring_interval > 0 ? 1 : 0

  name = var.monitoring_role_name != null ? var.monitoring_role_name : "${local.name_prefix}-rds-monitoring-role"

  assume_role_policy = data.aws_iam_policy_document.monitoring_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-rds-monitoring-role"
    }
  )

}

#############################################################
# Attach AWS Managed Policy
#############################################################

resource "aws_iam_role_policy_attachment" "monitoring" {

  count = var.monitoring_interval > 0 ? 1 : 0

  role = aws_iam_role.monitoring[0].name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

}