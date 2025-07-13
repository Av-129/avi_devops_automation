# #Default route table
# 
# 
# 
# #Public ALB Route Table
# 
# resource "aws_route" "all_traffic" {
#   count                  = 2
#   route_table_id         = aws_route_table.uat_pub_alb_route_table[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.IGW.id
# 
# }
# 
# 
# resource "aws_route_table" "uat_pub_alb_route_table" {
#   vpc_id = aws_vpc.main_vpc.id
#   count  = 2
#   tags = {
#     Name      = "${var.namespace}_pub_alb_route_table_1${var.public_alb_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
#   depends_on = [aws_vpc.main_vpc]
# }
# 
# 
# 
# 
# resource "aws_route_table" "uat_pvt_db_route_table" {
#   vpc_id = aws_vpc.main_vpc.id
#   count  = 2
#   tags = {
#     Name      = "${var.namespace}_pvt_db_route_table_1${var.private_db_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
#   depends_on = [aws_vpc.main_vpc]
# }
# 
# 
# 
# 
# 
# resource "aws_route_table" "uat_pvt_app_route_table" {
#   vpc_id = aws_vpc.main_vpc.id
#   count  = 2
#   tags = {
# 
#     Name      = "${var.namespace}_pvt_app_route_table_1${var.private_app_subnet_cidr[count.index]}"
#     Namespace = var.namespace
#   }
# 
#   depends_on = [aws_vpc.main_vpc]
# 
# }



# Public ALB Route Table (for Internet access over IPv4 and IPv6)
resource "aws_route_table" "uat_pub_alb_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  count  = 2

  tags = {
    Name      = "${var.namespace}_pub_alb_route_table_${count.index}"
    Namespace = var.namespace
  }

  depends_on = [aws_vpc.main_vpc]
}

# IPv4 Default Route (Public Internet)
resource "aws_route" "all_traffic_ipv4" {
  count                  = 2
  route_table_id         = aws_route_table.uat_pub_alb_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

# IPv6 Default Route (Public Internet)
resource "aws_route" "all_traffic_ipv6" {
  count                     = 2
  route_table_id            = aws_route_table.uat_pub_alb_route_table[count.index].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                = aws_internet_gateway.IGW.id
}

# Private DB Route Table (No direct internet access)
resource "aws_route_table" "uat_pvt_db_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  count  = 2

  tags = {
    Name      = "${var.namespace}_pvt_db_route_table_${count.index}"
    Namespace = var.namespace
  }

  depends_on = [aws_vpc.main_vpc]
}

# Private App Route Table (Uses Egress-Only Internet Gateway for IPv6)
resource "aws_route_table" "uat_pvt_app_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  count  = 2

  tags = {
    Name      = "${var.namespace}_pvt_app_route_table_${count.index}"
    Namespace = var.namespace
  }

  depends_on = [aws_vpc.main_vpc]
}

# Private App Route for IPv6 (Using Egress-Only IGW)
resource "aws_route" "pvt_app_ipv6" {
  count                     = 2
  route_table_id            = aws_route_table.uat_pvt_app_route_table[count.index].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id    = aws_egress_only_internet_gateway.eigw.id
}

# Egress-Only Internet Gateway for IPv6 Traffic
resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.main_vpc.id
}


resource "aws_route" "private_ipv4_nat" {
  count                  = 2
  route_table_id         = aws_route_table.uat_pvt_app_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
