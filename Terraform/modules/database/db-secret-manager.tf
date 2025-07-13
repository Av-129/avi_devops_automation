#resource "aws_secretsmanager_secret" "rds_db_secret" {
#description                    = "Store secret with KMS enabled for RDS PostgreSQL"
#force_overwrite_replica_secret = null
## kms_key_id                     = var.kms_id
#name                           = "${var.namespace}_postgres_db_secret"
#name_prefix                    = null
#policy                         = null
# recovery_window_in_days        = null
#}
#
#data "aws_secretsmanager_secret_version" "secret-1" {
#  secret_id = aws_secretsmanager_secret.rds_db_secret.id
#  depends_on = [aws_secretsmanager_secret.rds_db_secret]
#}
