# Create the Secrets
resource "aws_secretsmanager_secret" "this" {
  for_each    = { for s in var.secrets : s.name => s }
  name        = each.value.name
  description = each.value.description
  tags        = var.tags

  # When the secret resource is destroyed, run the AWS CLI command
  provisioner "local-exec" {
    when    = destroy
    command = "aws secretsmanager delete-secret --secret-id ${self.id} --force-delete-without-recovery --region eu-north-1"
  }
}

# Create the Secret Versions (stores the secret data)
resource "aws_secretsmanager_secret_version" "this" {
  for_each = { for s in var.secrets : s.name => s }
  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = jsonencode(each.value.secret_data)
}
