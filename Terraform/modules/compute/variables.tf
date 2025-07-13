variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c02fb55956c7d316" # Update as needed
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "iam_role_name" {
  description = "The name of the IAM role to assign to the EC2 instance"
  type        = string
}


variable "subnet_id" {
  description = "The ID of the subnet for the EC2 instance"
}

variable "security_group_id" {
  description = "Security group ID to attach to the instance"
}
