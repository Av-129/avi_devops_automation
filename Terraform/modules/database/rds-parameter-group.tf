# resource "aws_db_parameter_group" "postgres_rds_pg" {
#   description = var.rds-pg-description
#   family      = "postgres16"
#   name        = var.rds-pg-name
#   name_prefix = null
# 
#   parameter {
#     apply_method = "immediate"
#     name         = "log_connections"
#     value        = "1"
#   }
#   parameter {
#     apply_method = "immediate"
#     name         = "log_disconnections"
#     value        = "1"
#   }
#   parameter {
#     apply_method = "immediate"
#     name         = "log_error_verbosity"
#     value        = "verbose"
#   }
#   parameter {
#     apply_method = "immediate"
#     name         = "log_min_duration_statement"
#     value        = "300000"
#   }
#   parameter {
#     apply_method = "immediate"
#     name         = "pgaudit.log"
#     value        = "all"
#   }
#   parameter {
#     apply_method = "immediate"
#     name         = "pgaudit.role"
#     value        = "rds_pgaudit"
#   }
#   parameter {
#     apply_method = "pending-reboot"
#     name         = "shared_preload_libraries"
#     value        = "pg_stat_statements,pgaudit"
#   }
# 
#     parameter {
#     name  = "timezone"
#     value = "Asia/Calcutta"
#   }
# 
#   tags_all = {
#     map-dba      = "divyanshu"
#     map-migrated = "divyanshu"
#   }
# }