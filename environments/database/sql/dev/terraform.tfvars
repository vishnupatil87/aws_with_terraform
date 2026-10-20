#############################################################
# Project
#############################################################

project_name = "production-eks-platform"

environment = "dev"

#############################################################
# Database
#############################################################

db_identifier = "postgres"

db_name = "studentdb"

username = "postgres"

password = "ChangeMe123!"

#############################################################
# Engine
#############################################################

engine = "postgres"

engine_version = "17.10"

instance_class = "db.t3.micro"

#############################################################
# Storage
#############################################################

allocated_storage = 20

max_allocated_storage = 100

storage_type = "gp3"

#############################################################
# Availability
#############################################################

multi_az = false

#############################################################
# Backup
#############################################################

backup_retention_period = 1

#############################################################
# Monitoring
#############################################################

monitoring_interval = 0

performance_insights_enabled     = false
monitoring_role_name             = false
cloudwatch_log_retention_in_days = 7

create_cloudwatch_log_group = true
#############################################################
# Protection
#############################################################

deletion_protection = false

skip_final_snapshot = true

#############################################################
# Tags
#############################################################

tags = {
  Owner      = "DevOps Team"
  CostCenter = "Training"
  Terraform  = "true"
}