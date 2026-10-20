#############################################################
# RDS
#############################################################

output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "db_instance_identifier" {
  value = module.rds.db_instance_identifier
}

output "db_instance_arn" {
  value = module.rds.db_instance_arn
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_address" {
  value = module.rds.db_address
}

output "db_port" {
  value = module.rds.db_port
}

output "db_name" {
  value = module.rds.db_name
}

output "engine" {
  value = module.rds.engine
}

output "engine_version" {
  value = module.rds.engine_version
}

output "security_group_id" {
  value = module.rds.security_group_id
}

output "db_subnet_group_name" {
  value = module.rds.db_subnet_group_name
}