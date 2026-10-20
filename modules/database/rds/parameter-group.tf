#############################################################
# PostgreSQL Parameter Group
#
# This parameter group enables useful logging
# and production-friendly PostgreSQL settings.
#############################################################

resource "aws_db_parameter_group" "this" {

  name = "${local.name_prefix}-postgres-params"

  family = "postgres17"

  description = "Parameter Group for ${local.db_identifier}"

  ###########################################################
  # Logging Configuration
  ###########################################################

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_duration"
    value = "1"
  }

  parameter {
    name  = "log_statement"
    value = "ddl"
  }

  ###########################################################
  # Performance
  ###########################################################

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  ###########################################################
  # Autovacuum
  ###########################################################

  parameter {
    name  = "autovacuum"
    value = "1"
  }

  ###########################################################
  # Lock Monitoring
  ###########################################################

  parameter {
    name  = "log_lock_waits"
    value = "1"
  }

  ###########################################################
  # Timezone
  ###########################################################

  parameter {
    name  = "timezone"
    value = "UTC"
  }

  ###########################################################
  # Tags
  ###########################################################

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgres-params"
    }
  )

}