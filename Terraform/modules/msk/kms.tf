resource "aws_kms_key" "msk_kms" {
  description             = "KMS key for MSK encryption"
  deletion_window_in_days = 10

  tags = {
    Name = "msk-kms-key"
  }
}
