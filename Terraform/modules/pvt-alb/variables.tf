variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default = "abc-pvt-alb"
}

variable "internal" {
  description = "Set to true for a private ALB, false for a public ALB"
  type        = bool
}

variable "security_group_id" {
  description = "List of security group IDs to associate with the ALB"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
}

variable "message" {
  description = "Message for the default HTTPS fixed response"
  type        = string
  default     = "Default ALB response"
}

variable "enable_deletion_protection" {
  description = "Enable or disable ALB deletion protection"
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable or disable cross-zone load balancing for the ALB"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "Time (in seconds) before an idle connection is closed"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags to apply to ALB"
  type        = map(string)
  default     = {}
}
