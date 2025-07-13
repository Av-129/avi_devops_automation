# modules/msk/variables.tf
variable "namespace" {
  type    = string
  default = "abc"
}

variable "kafka_version" {
  type    = string
  default = "3.8.x"
}

variable "broker_instance_type" {
  type    = string
  default = "kafka.t3.small"
}

variable "number_of_broker_nodes" {
  type    = number
  default = 2
}

variable "ebs_volume_size" {
  type    = number
  default = 1000
}

variable "security_group_id" {  # Keep original name
  type = string
}

variable "private_subnet_ids" {  # Keep original name
  type = list(string)
}

variable "msk_sasl_username" {
  type = string
}

variable "msk_sasl_password" {
  type      = string
  sensitive = true
}

variable "secret_name" {
  type    = string
  default = "AmazonMSK_msk_auth_credentials"
}

# Remove unused variables like authentication_mechanism, kafka_msk_host