# # CloudWatch log groups remain the same
# resource "aws_cloudwatch_log_group" "valkey_slow_query_log" {
#   name              = "${var.namespace}_valkey_elasticache_slow_log_group"
#   retention_in_days = 365
# }
# 
# resource "aws_cloudwatch_log_group" "valkey_engine_logs" {
#   name              = "${var.namespace}_valkey_elasticache_engine_log_group"
#   retention_in_days = 365
# }
# 
# # Default Valkey user (must have the user name "default")
# resource "aws_elasticache_user" "valkey_default" {
#   user_id       = "${var.namespace}-valkey-default"
#   user_name     = "default"
#   engine        = "valkey"
#   access_string = "on +@all"
#   passwords     = [var.valkey_default_user_password]
# }
# 
# # Full-access Valkey user
# resource "aws_elasticache_user" "valkey_full_user" {
#   user_id       = "${var.namespace}-valkey-full-user"
#   user_name     = "${var.namespace}-valkey-full-user"
#   engine        = "valkey"
#   access_string = "on +@all"
#   passwords     = [var.valkey_full_user_password]
# }
# 
# # Read-only Valkey user
# resource "aws_elasticache_user" "valkey_read_user" {
#   user_id       = "${var.namespace}-valkey-read-user"
#   user_name     = "${var.namespace}-valkey-read-user"
#   engine        = "valkey"
#   access_string = "on +@read"
#   passwords     = [var.valkey_read_user_password]
# }
# 
# # Group the Valkey users into a single user group
# resource "aws_elasticache_user_group" "valkey_user_group" {
#   user_group_id = "${var.namespace}-valkey-user-group"
#   engine        = "valkey"
#   user_ids      = [
#     aws_elasticache_user.valkey_default.user_id,
#     aws_elasticache_user.valkey_full_user.user_id,
#     aws_elasticache_user.valkey_read_user.user_id
#   ]
# }
# 
# # ElastiCache replication group for Valkey
# resource "aws_elasticache_replication_group" "valkey_replication_group" {
#   automatic_failover_enabled = true
#   replication_group_id       = "${var.namespace}-valkey-elasticache"
#   description                = "${var.namespace} valkey elasticache cluster"
#   node_type                  = "cache.t4g.medium"
#   num_node_groups            = 3
#   replicas_per_node_group    = 1
#   engine                     = "valkey"
#   engine_version             = "8.0"  # Confirm the latest supported Valkey version
#   parameter_group_name       = aws_elasticache_parameter_group.abc_valkey.name
#   subnet_group_name          = aws_elasticache_subnet_group.ec_subnet_group.name
#   security_group_ids         = [var.security_group_id]
#   port                       = 6379
#   apply_immediately          = true
#   at_rest_encryption_enabled = true
#   transit_encryption_enabled = true
#   auto_minor_version_upgrade = true
#   multi_az_enabled           = false
#   maintenance_window         = "sat:05:00-sat:09:00"
#   snapshot_window            = "01:00-02:00"
#   snapshot_retention_limit   = 7
# 
#   log_delivery_configuration {
#     destination      = aws_cloudwatch_log_group.valkey_slow_query_log.name
#     destination_type = "cloudwatch-logs"
#     log_format       = "json"
#     log_type         = "slow-log"
#   }
#   log_delivery_configuration {
#     destination      = aws_cloudwatch_log_group.valkey_engine_logs.name
#     destination_type = "cloudwatch-logs"
#     log_format       = "json"
#     log_type         = "engine-log"
#   }
# 
#   user_group_ids = [aws_elasticache_user_group.valkey_user_group.user_group_id]
# 
#   tags = {
#     map-dba = "Divyanshu"
#   }
# }
