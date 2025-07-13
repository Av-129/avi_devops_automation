output "ecr_repository_urls" {
  description = "The URLs of the created ECR repositories"
  value       = { for repo, instance in aws_ecr_repository.this : repo => instance.repository_url }
}
