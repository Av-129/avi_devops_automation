#Internet Gateway attachment

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.namespace}_pub_IGW"
  }
  depends_on = [aws_vpc.main_vpc]
}
