variable "tags" {
  description = "Tags for the DynamoDB table."
  type        = map(string)
  default     = {}
}
