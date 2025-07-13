output "user_pool_id" {
  description = "The ID of the created Cognito User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "The ARN of the created Cognito User Pool"
  value       = aws_cognito_user_pool.this.arn
}
