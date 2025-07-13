variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of messages will be delayed"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "The maximum message size in bytes"
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "The time in seconds that a message will be retained"
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "The time in seconds that a receive call will wait for a message"
  type        = number
  default     = 0
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  type        = number
  default     = 30
}

variable "enable_dlq" {
  description = "Enable dead-letter queue"
  type        = bool
  default     = false
}

variable "max_receive_count" {
  description = "The maximum number of times a message can be received before being moved to the DLQ"
  type        = number
  default     = 5
}

variable "dlq_message_retention_seconds" {
  description = "The retention period for messages in the DLQ"
  type        = number
  default     = 1209600
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
