#pub alb subnet association with routes table

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.pub_alb_cidr_blocks)
  subnet_id      = aws_subnet.uat_pub_alb_subnet[count.index].id
  route_table_id = aws_route_table.uat_pub_alb_route_table[count.index].id
}



# # #pvt app subnet association with routes table

resource "aws_route_table_association" "pvt_app_subnet_association" {
  count          = length(var.pvt_app_cidr_blocks)
  subnet_id      = aws_subnet.uat_pvt_app_subnet[count.index].id
  route_table_id = aws_route_table.uat_pvt_app_route_table[count.index].id
}


# # # #pvt db subnet association with routes table

#resource "aws_route_table_association" "pvt_db_subnet_association" {
#  count          = length(var.pvt_db_cidr_blocks)
#  subnet_id      = aws_subnet.uat_pvt_db_subnet[count.index].id
#  route_table_id = aws_route_table.uat_pvt_db_route_table[count.index].id
#}


