# Allocate an Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.namespace}_nat_eip"
  }
}

# Create NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.uat_pub_alb_subnet[0].id  # Ensure it's a public subnet

  tags = {
    Name = "${var.namespace}_nat_gw"
  }

  depends_on = [aws_internet_gateway.IGW]
}
