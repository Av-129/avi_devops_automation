# # Public Subnet
# 
# 
# resource "aws_subnet" "uat_pub_alb_subnet" {
#   count             = length(var.pub_alb_cidr_blocks)
#   cidr_block        = var.pub_alb_cidr_blocks[count.index]
#   vpc_id            = aws_vpc.main_vpc.id
#   availability_zone = "${var.aws_region}${var.public_alb_subnet_cidr[count.index]}"
#   tags = {
#     Name      = "${var.namespace}_pub_alb_subnet_1${var.public_alb_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
#   depends_on = [aws_vpc.main_vpc]
# }
# 
# resource "aws_subnet" "uat_pvt_db_subnet" {
#   count             = length(var.pvt_db_cidr_blocks)
#   cidr_block        = var.pvt_db_cidr_blocks[count.index]
#   vpc_id            = aws_vpc.main_vpc.id
#   availability_zone = "${var.aws_region}${var.private_db_subnet_cidr[count.index]}"
#   tags = {
#     Name      = "${var.namespace}_pvt_db_subnet_1${var.private_db_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
#   depends_on = [aws_vpc.main_vpc]
# }
# 
# # # # # Private APP Subnet
# 
# resource "aws_subnet" "uat_pvt_app_subnet" {
#   count             = length(var.pvt_app_cidr_blocks)
#   cidr_block        = var.pvt_app_cidr_blocks[count.index]
#   vpc_id            = aws_vpc.main_vpc.id
#   availability_zone = "${var.aws_region}${var.private_app_subnet_cidr[count.index]}"
#   tags = {
#     Name      = "${var.namespace}_pvt_app_subnet_1${var.private_app_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
#   depends_on = [aws_vpc.main_vpc]
# }




# Public Subnet with IPv6
resource "aws_subnet" "uat_pub_alb_subnet" {
  count             = length(var.pub_alb_cidr_blocks)
  cidr_block        = var.pub_alb_cidr_blocks[count.index]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main_vpc.ipv6_cidr_block, 8, count.index) # Allocating IPv6 CIDR
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = "${var.aws_region}${var.public_alb_subnet_cidr[count.index]}"
  assign_ipv6_address_on_creation = true  # Enables auto-assignment of IPv6 to instances

  tags = {
    Name      = "${var.namespace}_pub_alb_subnet_${count.index}"
    Namespace = var.namespace
  }
  depends_on = [aws_vpc.main_vpc]
}

# Private DB Subnet with IPv6
#resource "aws_subnet" "uat_pvt_db_subnet" {
#  count             = length(var.pvt_db_cidr_blocks)
#  cidr_block        = var.pvt_db_cidr_blocks[count.index]
#  ipv6_cidr_block   = cidrsubnet(aws_vpc.main_vpc.ipv6_cidr_block, 8, count.index + length(var.pub_alb_cidr_blocks))
#  vpc_id            = aws_vpc.main_vpc.id
#  availability_zone = "${var.aws_region}${var.private_db_subnet_cidr[count.index]}"
#  assign_ipv6_address_on_creation = true
#
#  tags = {
#    Name      = "${var.namespace}_pvt_db_subnet_${count.index}"
#    Namespace = var.namespace
#  }
#  depends_on = [aws_vpc.main_vpc]
#}

# Private APP Subnet with IPv6
resource "aws_subnet" "uat_pvt_app_subnet" {
  count             = length(var.pvt_app_cidr_blocks)
  cidr_block        = var.pvt_app_cidr_blocks[count.index]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main_vpc.ipv6_cidr_block, 8, count.index + length(var.pub_alb_cidr_blocks) + length(var.pvt_db_cidr_blocks))
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = "${var.aws_region}${var.private_app_subnet_cidr[count.index]}"
  assign_ipv6_address_on_creation = true

  tags = {
    Name      = "${var.namespace}_pvt_app_subnet_${count.index}"
    Namespace = var.namespace
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [aws_vpc.main_vpc]
}
