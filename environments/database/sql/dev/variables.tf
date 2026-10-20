variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
#############################################################
# Project
#############################################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

#############################################################
# Database
#############################################################

variable "db_identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}

#############################################################
# Engine
#############################################################

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

#############################################################
# Storage
#############################################################

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

#############################################################
# HA
#############################################################

variable "multi_az" {
  type = bool
}

#############################################################
# Backup
#############################################################

variable "backup_retention_period" {
  type = number
}

#############################################################
# Monitoring
#############################################################

variable "monitoring_interval" {
  type = number
}

variable "performance_insights_enabled" {
  type = bool
}

#############################################################
# Protection
#############################################################

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

#############################################################
# Tags
#############################################################

variable "tags" {
  type = map(string)
}

variable "monitoring_role_name" {
  type = bool
}

variable "cloudwatch_log_retention_in_days" {

}

variable "create_cloudwatch_log_group" {
  type = bool
}