#############################################################
# RDS Security Group
#############################################################

resource "aws_security_group" "this" {

  name        = "${local.name_prefix}-rds-sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-rds-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }

}

#############################################################
# Allow PostgreSQL Traffic
#############################################################

resource "aws_vpc_security_group_ingress_rule" "postgres" {

  for_each = {
    for idx, sg_id in var.allowed_security_group_ids :
    tostring(idx) => sg_id
  }
  
  #for_each = toset(var.allowed_security_group_ids)

  security_group_id = aws_security_group.this.id

  referenced_security_group_id = each.value

  from_port = var.port
  to_port   = var.port

  ip_protocol = "tcp"

  description = "Allow PostgreSQL access"

}

#############################################################
# Outbound Traffic
#############################################################

resource "aws_vpc_security_group_egress_rule" "all" {

  security_group_id = aws_security_group.this.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow outbound traffic"

}


#############################################################
# All Internal VPC Traffic
#############################################################

resource "aws_vpc_security_group_ingress_rule" "vpc" {

  security_group_id = aws_security_group.this.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "VPC Communication"

}