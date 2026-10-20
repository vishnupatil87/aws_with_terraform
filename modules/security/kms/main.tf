#################################################
# KMS KEY
#################################################

resource "aws_kms_key" "this" {

  description = var.description

  deletion_window_in_days = var.deletion_window_in_days

  enable_key_rotation = var.enable_key_rotation

  policy = data.aws_iam_policy_document.kms.json

  tags = merge(

    var.common_tags,

    {
      Name = "${var.environment}-${var.key_alias}"
    }
  )
}

#################################################
# KMS ALIAS
#################################################

resource "aws_kms_alias" "this" {

  name = "alias/${var.environment}-${var.key_alias}"

  target_key_id = aws_kms_key.this.key_id
}

#################################################
# KMS POLICY
#################################################

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms" {

  #################################################
  # ACCOUNT ROOT
  #################################################

  statement {

    sid = "EnableRootPermissions"

    effect = "Allow"

    principals {

      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = ["*"]
  }

  #################################################
  # CLOUDWATCH LOGS
  #################################################

  statement {

    sid = "AllowCloudWatchLogs"

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "logs.ap-south-1.amazonaws.com"
      ]
    }

    actions = [

      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }

  #################################################
  # EKS
  #################################################

  statement {

    sid = "AllowEKS"

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "eks.amazonaws.com"
      ]
    }

    actions = [

      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }

  #################################################
  # EC2 / EBS
  #################################################

  statement {

    sid = "AllowEC2"

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [

      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }
}