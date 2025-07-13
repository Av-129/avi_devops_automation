locals {
  default_table_name = "terraform-state-lock"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = local.default_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
