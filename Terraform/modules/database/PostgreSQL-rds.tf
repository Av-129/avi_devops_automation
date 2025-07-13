# 
# resource "aws_db_instance" "postgres_db" {
#   allocated_storage                     = 50
#   allow_major_version_upgrade           = null
#   apply_immediately                   = true
#   auto_minor_version_upgrade          = true
#   # availability_zone                   = "ap-south-2a"
#   backup_retention_period             = 7
#   backup_target                       = "region"
#   backup_window                       = "20:34-21:04"
#   # ca_cert_identifier                  = "rds-ca-rsa2048-g1"
#   character_set_name                    = null
#   copy_tags_to_snapshot                 = true
#   custom_iam_instance_profile           = null
#   customer_owned_ip_enabled             = false
#   db_name                             = "abc_connecting_database"
#   db_subnet_group_name                = aws_db_subnet_group.rds-db-subnet-group.name
#   delete_automated_backups              = true
#   deletion_protection                   = false
#   domain                                = null
#   domain_iam_role_name                  = null
#   enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]
#   engine                                = "postgres"
#   engine_version                        = "16.3"
#   final_snapshot_identifier             = null
#   iam_database_authentication_enabled   = true
#   identifier                            = "abc-postgres-connecting-database"
#   identifier_prefix                     = null
#   instance_class                        = "db.t4g.micro"
#   #iops                                  = 3000
#   # kms_key_id                            = var.kms_rds_id
#   license_model                         = "postgresql-license"
#   maintenance_window = "tue:12:39-tue:13:09"
#  #  manage_master_user_password           = false // mark this true if you want rds to create secret manager for you with creds
# #   master_user_secret_kms_key_id         = null
#  max_allocated_storage                 = 250
#   monitoring_interval                   = 60
#   monitoring_role_arn                   = "arn:aws:iam::${var.account-id}:role/rds-monitoring-role"
#   multi_az                              = true
#   nchar_character_set_name              = null
#   network_type                          = "IPV4"
#   option_group_name                     = "default:postgres-16"
#   parameter_group_name                  = "abc-rds-parameter-group"
#   # password                              = jsondecode(data.aws_secretsmanager_secret_version.secret-1.secret_string).masterpassword-cnb-uat-db
#   password                              = var.master_db_password // if you want aws to manage the master user and password then comment this
#   performance_insights_enabled          = true
#   # performance_insights_kms_key_id       = var.kms_rds_id
#   performance_insights_retention_period = 7
#   port                                  = 5432
#   publicly_accessible                   = false
#   replica_mode                          = null
#   replicate_source_db                   = null
#   skip_final_snapshot                   = true
#   # snapshot_identifier                   = null
#   storage_encrypted                     = true
# #   storage_throughput                    = 125
#    storage_type                          = "gp3"
#   timezone               = null
#   username               = "abc_cnb_connecting_uat"
#   vpc_security_group_ids      = [var.security_group_id]
# 
#   snapshot_identifier  = var.db_snapshot_identifier != "" ? var.db_snapshot_identifier : null
# 
#     tags = {
#     map-dba      = "divyanshu"
#     Auto-Restart = "1"
#     # Start        = "1100"
#     # Stop         = "2100"
#   }
# }

