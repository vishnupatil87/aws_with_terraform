#############################################################
# Project Configuration
#############################################################

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["dev", "qa", "uat", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, qa, uat or prod."
  }
}

#############################################################
# Network Configuration
#############################################################

variable "vpc_id" {
  description = "Existing VPC ID."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least two private subnets are required."
  }
}

variable "allowed_security_group_ids" {
  description = "Security Groups allowed to connect to RDS."
  type        = list(string)
}

#############################################################
# KMS
#############################################################

variable "kms_key_arn" {
  description = "KMS Key ARN used for storage encryption."
  type        = string
}

#############################################################
# Database Configuration
#############################################################

variable "db_identifier" {
  description = "Database identifier."
  type        = string
}

variable "db_name" {
  description = "Initial database name."
  type        = string
}

variable "username" {
  description = "Master username."
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Master password."
  type        = string
  sensitive   = true
}

#############################################################
# Engine Configuration
#############################################################

variable "engine" {
  description = "Database engine."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version."
  type        = string
}

variable "instance_class" {
  description = "RDS instance type."
  type        = string
}

#############################################################
# Storage Configuration
#############################################################

variable "allocated_storage" {
  description = "Initial storage size in GB."
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum autoscaling storage."
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type."
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Enable storage encryption."
  type        = bool
  default     = true
}

#############################################################
# Network Access
#############################################################

variable "port" {
  description = "Database port."
  type        = number
  default     = 5432
}

variable "publicly_accessible" {
  description = "Public accessibility."
  type        = bool
  default     = true
}

#############################################################
# High Availability
#############################################################

variable "multi_az" {
  description = "Enable Multi-AZ."
  type        = bool
  default     = false
}

#############################################################
# Backup Configuration
#############################################################

variable "backup_retention_period" {
  description = "Backup retention period."
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window."
  type        = string
  default     = "02:00-03:00"
}

#############################################################
# Maintenance
#############################################################

variable "maintenance_window" {
  description = "Preferred maintenance window."
  type        = string
  default     = "Sun:04:00-Sun:05:00"
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor upgrades."
  type        = bool
  default     = true
}

#############################################################
# Monitoring
#############################################################

variable "performance_insights_enabled" {
  description = "Enable Performance Insights."
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval."
  type        = number
  default     = 0
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch log exports."
  type        = list(string)

  default = [
    "postgresql"
  ]
}

#############################################################
# Protection
#############################################################

variable "deletion_protection" {
  description = "Enable deletion protection."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot."
  type        = bool
  default     = true
}

#############################################################
# Tags
#############################################################

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}


variable "performance_insights_kms_key_id" {
  description = "KMS key used for Performance Insights."
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "Apply changes immediately."
  type        = bool
  default     = false
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication."
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "Specific AZ for single AZ deployment."
  type        = string
  default     = null
}

variable "ca_cert_identifier" {
  description = "CA certificate identifier."
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period."
  type        = number
  default     = 7
}


variable "create_cloudwatch_log_group" {

}

variable "cloudwatch_log_retention_in_days" {

}

variable "monitoring_role_name" {

}