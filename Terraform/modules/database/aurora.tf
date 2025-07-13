# resource "aws_rds_cluster" "aurora_cluster" {
#   cluster_identifier        = "abc-aurora-cluster"
#   engine                   = "aurora-postgresql"
#   engine_version           = "16"
#   database_name            = "abc_aurora_db"
#   master_username          = "auroraadmin"
#   master_password          = var.aurora_master_db_password
#   backup_retention_period  = 7
#   preferred_backup_window  = "02:00-03:00"
#   vpc_security_group_ids   = [var.security_group_id]
#   db_subnet_group_name     = aws_db_subnet_group.aurora_subnet_group.name
#   deletion_protection      = false
#   skip_final_snapshot      = true
#   apply_immediately        = true
#   storage_encrypted        = true
#   port                     = 5432
#     # Allow major version upgrades when needed
#   allow_major_version_upgrade = true
# 
#   tags = {
#     Name        = "abc-aurora-cluster"
#     Environment = var.environment
#   }
# }
# 
# resource "aws_rds_cluster_instance" "aurora_instances" {
#   count              = var.aurora_instance_count
#   identifier        = "${var.aurora_cluster_identifier}-instance-${count.index}"
#   cluster_identifier = aws_rds_cluster.aurora_cluster.id
#   instance_class     = var.aurora_instance_class
#   engine             = var.aurora_engine  # Ensure this variable is defined
#   engine_version     = var.aurora_engine_version
# 
#   publicly_accessible = false
#   apply_immediately  = true
#   
# 
#   tags = {
#     Name = "${var.namespace}-aurora-instance-${count.index}"
#   }
# }

