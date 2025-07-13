resource "aws_vpc" "main_vpc" {
  cidr_block           = var.pvt_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
 tags = {
    Name = "${var.namespace}_pvt_vpc"
  }
}
