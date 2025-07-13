resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  auto_verified_attributes = var.auto_verified_attributes

  password_policy {
    minimum_length    = var.password_policy_minimum_length
    require_uppercase = var.password_policy_require_uppercase
    require_lowercase = var.password_policy_require_lowercase
    require_numbers   = var.password_policy_require_numbers
    require_symbols   = var.password_policy_require_symbols
  }
  
  # Additional configuration options (e.g., MFA, lambda triggers) can be added here.
}