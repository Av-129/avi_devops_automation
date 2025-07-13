variable "account-id" {
  description = "Enter the aws account no for the audit bucket account name format (312767894698-audit-dnd)"
  default     = "167062668708"
}

variable "bucket1" {
  default     = "abc-app-bucket"
}

#variable "sns_s3_event_name" {
#  description = "Enter SNS Topic Name"
#  default     = "cnb_uat_s3_sns"
#}
#
#variable "sns_s3_event_arn" {
#  description = "Enter S3 SNS Topic ARN"
#  default     = "arn:aws:sns:ap-south-1:6789698:cnb_uat_s3_sns"
#}
