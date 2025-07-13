
resource "aws_kms_key" "secret_manager_kms" {
  bypass_policy_lockout_safety_check = null
  custom_key_store_id                = null
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  deletion_window_in_days            = null
  description                        = "Alerts Keys"
  enable_key_rotation                = true
  is_enabled                         = true
  key_usage                          = "ENCRYPT_DECRYPT"
  multi_region                       = false
  tags = {
    Name = "${var.namespace}_secretmanager_kms_key"
  }

}

resource "aws_kms_alias" "secret_manager_kms_alias" {
  name          = var.secret
  target_key_id = aws_kms_key.secret_manager_kms.id
}
