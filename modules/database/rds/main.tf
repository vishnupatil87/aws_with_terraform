#############################################################
# Amazon RDS MariaDB Instance
#############################################################

resource "aws_db_instance" "this" {

  ###########################################################
  # General
  ###########################################################

  identifier = local.db_identifier

  engine         = var.engine
  engine_version = var.engine_version

  instance_class = var.instance_class

  ###########################################################
  # Database
  ###########################################################

  db_name  = var.db_name
  username = var.username
  password = var.password

  port = var.port

  ###########################################################
  # Storage
  ###########################################################

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted

  kms_key_id = var.kms_key_arn

  ###########################################################
  # Network
  ###########################################################

  publicly_accessible = var.publicly_accessible

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  ###########################################################
  # Parameter Group
  ###########################################################

  parameter_group_name = aws_db_parameter_group.this.name

  ###########################################################
  # High Availability
  ###########################################################

  multi_az = var.multi_az

  ###########################################################
  # Backup
  ###########################################################

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  copy_tags_to_snapshot = true

  delete_automated_backups = true

  ###########################################################
  # Maintenance
  ###########################################################

  maintenance_window = var.maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  allow_major_version_upgrade = false

  apply_immediately = var.apply_immediately

  ###########################################################
  # Snapshot / Deletion
  ###########################################################

  deletion_protection = var.deletion_protection

  skip_final_snapshot = var.skip_final_snapshot

  final_snapshot_identifier = !var.skip_final_snapshot ? "${local.db_identifier}-final-${formatdate("YYYYMMDDhhmm", timestamp())}" : null

  ###########################################################
  # Monitoring
  ###########################################################

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  monitoring_interval = var.monitoring_interval

  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.monitoring[0].arn : null

  ###########################################################
  # Performance Insights
  ###########################################################

  performance_insights_enabled = var.performance_insights_enabled

  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  performance_insights_kms_key_id = var.performance_insights_enabled ? (
    var.performance_insights_kms_key_id != null ?
    var.performance_insights_kms_key_id :
    var.kms_key_arn
  ) : null

  ###########################################################
  # Security
  ###########################################################

  iam_database_authentication_enabled = var.iam_database_authentication_enabled


  ###########################################################
  # Misc
  ###########################################################

  network_type = "IPV4"

  availability_zone = var.availability_zone

  ca_cert_identifier = var.ca_cert_identifier

  ###########################################################
  # Tags
  ###########################################################

  tags = local.common_tags

  ###########################################################
  # Lifecycle
  ###########################################################

  lifecycle {

    ignore_changes = [
      password
    ]

  }

  depends_on = [
    aws_db_subnet_group.this,
    aws_security_group.this,
    aws_db_parameter_group.this
  ]

}