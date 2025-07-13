variable "vpc_id" {
  description = "VPC ID where the security group will be created"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH"
  default     = ["0.0.0.0/0"]
}
