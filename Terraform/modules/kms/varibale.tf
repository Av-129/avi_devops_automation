variable "namespace" {
  default = "abc"
}
variable "secret" {
  description = "Enter the Secret KMS Name"
  default     = "alias/abc_secretmanager_kms_key"
}
variable "ecr" {
  description = "Enter the ECR KMS Name"
  default     = "alias/abc_ecr_kms_key"
}
