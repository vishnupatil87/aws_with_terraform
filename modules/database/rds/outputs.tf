#############################################################
# Database Information
#############################################################

output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_identifier" {
  description = "RDS Instance Identifier"
  value       = aws_db_instance.this.identifier
}

output "db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.this.arn
}

#############################################################
# Connection Information
#############################################################

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "RDS Hostname"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Database Port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.this.db_name
}

#############################################################
# Engine Information
#############################################################

output "engine" {
  description = "Database Engine"
  value       = aws_db_instance.this.engine
}

output "engine_version" {
  description = "Database Engine Version"
  value       = aws_db_instance.this.engine_version
}

output "instance_class" {
  description = "RDS Instance Class"
  value       = aws_db_instance.this.instance_class
}

#############################################################
# Networking
#############################################################

output "security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.this.id
}

output "db_subnet_group_name" {
  description = "DB Subnet Group"
  value       = aws_db_subnet_group.this.name
}

#############################################################
# Parameter Group
#############################################################

output "parameter_group_name" {
  description = "Parameter Group Name"
  value       = aws_db_parameter_group.this.name
}

#############################################################
# Monitoring
#############################################################

output "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group"

  value = var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.postgresql[0].name : null
}

output "monitoring_role_arn" {
  description = "Enhanced Monitoring IAM Role"

  value = var.monitoring_interval > 0 ? aws_iam_role.monitoring[0].arn : null
}

#############################################################
# Availability
#############################################################

output "availability_zone" {
  description = "Availability Zone"
  value       = aws_db_instance.this.availability_zone
}

output "multi_az" {
  description = "Multi AZ Status"
  value       = aws_db_instance.this.multi_az
}

#############################################################
# Storage
#############################################################

output "allocated_storage" {
  description = "Allocated Storage"
  value       = aws_db_instance.this.allocated_storage
}

output "max_allocated_storage" {
  description = "Maximum Allocated Storage"
  value       = aws_db_instance.this.max_allocated_storage
}

output "storage_type" {
  description = "Storage Type"
  value       = aws_db_instance.this.storage_type
}

output "storage_encrypted" {
  description = "Storage Encryption"
  value       = aws_db_instance.this.storage_encrypted
}

#############################################################
# Backup
#############################################################

output "backup_retention_period" {
  description = "Backup Retention Period"
  value       = aws_db_instance.this.backup_retention_period
}