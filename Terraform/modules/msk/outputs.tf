output "msk_cluster_arn" {
  description = "ARN of the MSK cluster"
  value       = aws_msk_cluster.msk.arn
}

output "msk_cluster_name" {
  description = "Name of the MSK cluster"
  value       = aws_msk_cluster.msk.cluster_name
}

output "msk_secret_arn" {
  description = "ARN of the MSK secret"
  value       = aws_secretsmanager_secret.msk_secret.arn
}

output "msk_sasl_username" {
  description = "MSK SASL Username"
  value       = local.secret_data["username"]
}

output "msk_sasl_password" {
  description = "MSK SASL Password"
  value       = local.secret_data["password"]
  sensitive   = true
}

output "kafka_msk_host" {
  description = "MSK Broker Host"
  value       = aws_msk_cluster.msk.bootstrap_brokers_sasl_scram
}

output "autoscale_role_arn" {
  description = "ARN of the autoscaling IAM role"
  value       = aws_iam_role.msk_autoscale.arn
}

