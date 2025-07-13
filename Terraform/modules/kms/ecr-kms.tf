
resource "aws_kms_key" "ecr_kms" {
  bypass_policy_lockout_safety_check = null
  custom_key_store_id                = null
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  deletion_window_in_days            = null
  description                        = "abc ECR Key"
  enable_key_rotation                = true
  is_enabled                         = true
  key_usage                          = "ENCRYPT_DECRYPT"
  multi_region                       = false


  tags = {
    Name = "${var.namespace}_ecr_kms_key"
  }

}

resource "aws_kms_alias" "ecr_kms_alias" {
  name          = var.ecr
  target_key_id = aws_kms_key.ecr_kms.id
}