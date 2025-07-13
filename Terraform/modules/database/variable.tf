variable "namespace" {
  default = "abc"
}

variable "elsticache-subnet-group-name" {
  default = "abc-pvt-elasticache-db-subnet-group"
}

variable "account-id" {
  default     = "167062668708"
}

variable "rds-pg-name" {
  default = "abc-rds-parameter-group"
}


variable "rds-db-subnet-group-name" {
  default = "abc_pvt_db_subnet_group"
}


#variable "kms_id" {
#  default = "arn:aws:kms:ap-south-2:62668708:key/378e4bdb-5757-45b4-af5a-16c98104634e"
#}

variable "rds-pg-description" {
  default = "abc-rds-parameter-group"
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
 description = "Security Group ID for EKS Nodes"
  type        = string

}


variable "master_db_password" {
  description = "The master database password"
  type        = string
  sensitive   = true
  default     = "abc!!123"  # Use a secure value in practice!
}

variable "db_snapshot_identifier" {
  description = "Identifier of the snapshot from which to restore the DB instance. Leave empty for creating a new instance."
  type        = string
  default     = ""
}


# Define the variable for the Redis auth token with an inline default value
variable "redis_auth_token" {
  description = "The auth token for Redis. Must be between 16 and 128 characters."
  type        = string
  default     = "abcsecurepassword1233"  # Replace with your secure password
}


variable "redis_default_user_password" {
  description = "Password for the default Redis user"
  type        = string
  sensitive   = true
  default     = "DefaultUserSecret123!"  # example value
}

variable "redis_full_user_password" {
  description = "Password for the full-access Redis user"
  type        = string
  sensitive   = true
  default     = "FullUserSecret123!"  # example value
}

variable "redis_read_user_password" {
  description = "Password for the read-only Redis user"
  type        = string
  sensitive   = true
  default     = "ReadUserSecret123!"  # example value
}





variable "aurora_instance_class" {
  description = "The instance type for Aurora instances"
  type        = string
  default     = "db.r6g.large"  # Change as needed
}

variable "aurora_instance_count" {
  description = "Number of Aurora instances to create"
  type        = number
  default     = 2  # Adjust as needed
}

variable "aurora_engine" {
  description = "Aurora database engine type"
  type        = string
  default     = "aurora-postgresql"
}

variable "aurora_engine_version" {
  description = "Aurora database engine version"
  type        = string
  default     = "16"  # Example version
}

variable "aurora_cluster_identifier" {
  description = "The identifier for the Aurora cluster"
  type        = string
  default     = "my-aurora-cluster"  # You can change this as needed
}


variable "environment" {
  description = "The environment for the Aurora database (e.g., dev, staging, production)"
  type        = string
  default     = "dev"  # Change this as needed
}

variable "aurora_master_db_password" {
  description = "The master database password for the Aurora cluster"
  type        = string
  sensitive   = true
  default     = "SuperSecurePassword123"  # Replace with a secure value or remove the default in production
}