output "secret_arns" {
  description = "Mapping of secret names to their ARNs"
  value       = { for secret_name, secret in aws_secretsmanager_secret.this : secret_name => secret.arn }
}
