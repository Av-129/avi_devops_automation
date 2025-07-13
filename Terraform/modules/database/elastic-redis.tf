# Create a CloudWatch log group for Redis slow query logs
resource "aws_cloudwatch_log_group" "redis_slow_query_log" {
  name              = "${var.namespace}_redis_elasticache_slow_log_group"
  retention_in_days = 365
}

# Create a CloudWatch log group for Redis engine logs
resource "aws_cloudwatch_log_group" "redis_engine_logs" {
  name              = "${var.namespace}_redis_elasticache_engine_log_group"
  retention_in_days = 365
}

# Default Redis user (must have the user name "default")
resource "aws_elasticache_user" "redis_default" {
  user_id       = "${var.namespace}-redis-default"
  user_name     = "default"
  engine        = "redis"
  access_string = "on +@all"  # Adjust permissions as required
  passwords     = [var.redis_default_user_password]
}


# Full-access Redis user with hyphenated user_id
resource "aws_elasticache_user" "redis_full_user" {
  user_id       = "${var.namespace}-redis-full-user"   # Use hyphens instead of underscores
  user_name     = "${var.namespace}-redis-full-user"   # Update similarly if needed
  engine        = "redis"
  access_string = "on +@all"  # Grants full command access
  passwords     = [var.redis_full_user_password]
}

# Read-only Redis user with hyphenated user_id
resource "aws_elasticache_user" "redis_read_user" {
  user_id       = "${var.namespace}-redis-read-user"   # Use hyphens instead of underscores
  user_name     = "${var.namespace}-redis-read-user"   # Update similarly if needed
  engine        = "redis"
  access_string = "on +@read"  # Grants read-only command access
  passwords     = [var.redis_read_user_password]
}


# Group the three users into a single user group
resource "aws_elasticache_user_group" "redis_user_group" {
  user_group_id = "${var.namespace}-redis-user-group"
  engine        = "redis"
  user_ids      = [
    aws_elasticache_user.redis_default.user_id,
    aws_elasticache_user.redis_full_user.user_id,
    aws_elasticache_user.redis_read_user.user_id
  ]
}


# Elasticache replication group for Redis
resource "aws_elasticache_replication_group" "replication_group" {
  automatic_failover_enabled = true
  replication_group_id       = "abct-redis-elasticache"
  description                = "abc-redis-elasticache"
  node_type                  = "cache.t4g.medium"
  num_node_groups            = 3
  replicas_per_node_group    = 1
  engine                     = "redis"
  engine_version             = "7.1"
  parameter_group_name       = aws_elasticache_parameter_group.abc_redis.name
  subnet_group_name          = aws_elasticache_subnet_group.ec_subnet_group.name
  security_group_ids         = [var.security_group_id]
  port                       = 6379
  apply_immediately          = true
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auto_minor_version_upgrade = true
  multi_az_enabled           = false
  maintenance_window         = "sat:05:00-sat:09:00"
  snapshot_window            = "01:00-02:00"
  snapshot_retention_limit   = 7

  # Set the auth token (password) using the variable
  # auth_token = var.redis_auth_token

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_slow_query_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_engine_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  # Attach the user group to enable ACL-based authentication
  user_group_ids = [aws_elasticache_user_group.redis_user_group.user_group_id]

  tags = {
    map-dba = "Divyanshu"
  }
}
