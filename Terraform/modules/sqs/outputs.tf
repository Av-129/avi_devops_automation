output "sqs_queue_id" {
  description = "The ID of the SQS queue"
  value       = aws_sqs_queue.this.id
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "dlq_arn" {
  description = "The ARN of the dead-letter queue"
  value       = var.enable_dlq ? aws_sqs_queue.dlq[0].arn : null
}
