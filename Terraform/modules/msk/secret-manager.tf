resource "aws_secretsmanager_secret" "msk_secret" {
  name        = var.secret_name
  description = "Secret for MSK SASL authentication"
  kms_key_id   = aws_kms_key.msk_kms.arn

  tags = {
    Name        = var.secret_name
    Environment = "production"
  }
    provisioner "local-exec" {
    when    = destroy
    command = "aws secretsmanager delete-secret --secret-id ${self.id} --force-delete-without-recovery --region ap-south-2"
  }
}

resource "aws_secretsmanager_secret_version" "msk_secret_version" {
  secret_id     = aws_secretsmanager_secret.msk_secret.id
  secret_string = jsonencode({
    "username" : var.msk_sasl_username,
    "password" : var.msk_sasl_password
  })
}



data "aws_secretsmanager_secret" "msk_secret" {
  name = aws_secretsmanager_secret.msk_secret.name
}

data "aws_secretsmanager_secret_version" "msk_secret_version" {
  secret_id = data.aws_secretsmanager_secret.msk_secret.id
}

locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.msk_secret_version.secret_string)
}
