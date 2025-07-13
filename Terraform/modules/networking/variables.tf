# variable "aws_region" {
# 
#   description = "The region in which you would like to create a VPC"
#   default     = "ap-south-2"
#   nullable    = false
# }
# 
# 
# variable "account_name" {
# 
#   description = "AWS Account Name"
#   default     = "Polaris"
#   nullable    = false
# }
# 
# variable "pvt_cidr_block" {
#   description = "the primary CIDR block for the VPC"
#   default     = "10.0.0.0/16"
#   nullable    = false
# }
# 
# variable "namespace" {
#   default  = "polaris"
#   nullable = false
# }
# 
# variable "public_alb_subnet_cidr" {
#   description = "avaialbility zones keywords to use during naming"
#   type        = list(string)
#   default     = ["a", "b"]
#   nullable    = false
# }
# 
# 
# variable "pub_alb_cidr_blocks" {
#   description = "The list of CIDR blocks for public subnet"
#   type        = list(string)
#   default     = ["10.0.100.0/24", "10.0.110.0/24"]
# }
# 
# 
# 
# variable "private_db_subnet_cidr" {
#   description = "The list of CIDR blocks for private subnet"
#   type        = list(string)
#   default     = ["a", "b"]
#   nullable    = false
# }
# 
# 
# variable "pvt_db_cidr_blocks" {
#   description = "The list of CIDR blocks for private subnet"
#   type        = list(string)
#   default     = ["10.0.120.0/24", "10.0.121.0/24"]
# }
# 
# 
# variable "private_app_subnet_cidr" {
#   description = "The list of CIDR blocks for private subnet"
#   type        = list(string)
#   default     = ["a", "b"]
#   nullable    = false
# }
# 
# variable "pvt_app_cidr_blocks" {
#   description = "The list of CIDR blocks for public subnet"
#   type        = list(string)
#   default     = ["10.0.130.0/24", "10.0.131.0/24"]
# }



variable "aws_region" {
  description = "The region in which you would like to create a VPC"
  default     = "ap-south-1"
  nullable    = false
}

variable "account_name" {
  description = "AWS Account Name"
  default     = "PoC"
  nullable    = false
}

variable "pvt_cidr_block" {
  description = "The primary IPv4 CIDR block for the VPC"
  default     = "10.0.0.0/16"
  nullable    = false
}

variable "namespace" {
  default  = "poC"
  nullable = false
}

# IPv6 Configuration
variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
  default     = true
}

variable "ipv6_subnet_prefix" {
  description = "The IPv6 subnet prefix for subnets (AWS provides a /56, and we subnet it further)"
  type        = string
  default     = "00" # This will be used in cidrsubnet()
}

variable "public_alb_subnet_cidr" {
  description = "Availability zones keywords to use during naming"
  type        = list(string)
  default     = ["a", "b"]
  nullable    = false
}

variable "pub_alb_cidr_blocks" {
  description = "The list of IPv4 CIDR blocks for public subnet"
  type        = list(string)
  default     = ["10.0.100.0/24", "10.0.110.0/24"]
}

variable "pvt_alb_cidr_blocks_ipv6" {
  description = "The list of IPv6 CIDR blocks for public subnet"
  type        = list(string)
  default     = ["00", "01"] # IPv6 subnet allocations
}

variable "private_db_subnet_cidr" {
  description = "The list of CIDR blocks for private database subnets"
  type        = list(string)
  default     = ["a", "b"]
  nullable    = false
}

variable "pvt_db_cidr_blocks" {
  description = "The list of IPv4 CIDR blocks for private database subnet"
  type        = list(string)
  default     = ["10.0.120.0/24", "10.0.121.0/24"]
}

variable "pvt_db_cidr_blocks_ipv6" {
  description = "The list of IPv6 CIDR blocks for private database subnet"
  type        = list(string)
  default     = ["02", "03"] # IPv6 subnet allocations
}

variable "private_app_subnet_cidr" {
  description = "The list of CIDR blocks for private app subnets"
  type        = list(string)
  default     = ["a", "b"]
  nullable    = false
}

variable "pvt_app_cidr_blocks" {
  description = "The list of IPv4 CIDR blocks for private app subnet"
  type        = list(string)
  default     = ["10.0.130.0/24", "10.0.131.0/24"]
}

variable "pvt_app_cidr_blocks_ipv6" {
  description = "The list of IPv6 CIDR blocks for private app subnet"
  type        = list(string)
  default     = ["04", "05"] # IPv6 subnet allocations
}


variable "cluster_name" {
  description = "Enter the EKS Cluster Name"
  default     = "polaris-cluster"
}