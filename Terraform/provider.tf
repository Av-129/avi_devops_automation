# provider "aws" {
#   region = "ap-south-2"
# }
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }
# 
# terraform {
#   backend "s3" {
#     bucket = "cnb-uat-tf-state-bucket"
#     key    = "cnb_uat_tf_state"
#     region = "ap-south-2"
#   }
# }
# 
# 
# 
# # Configure the AWS Provider
# provider "aws" {
#   region = var.aws_region
# 
# 
#   default_tags {
#     tags = {
#       map-migrated = "divyanshu"
#       ENV          = "abc"
#     }
#   }
# }