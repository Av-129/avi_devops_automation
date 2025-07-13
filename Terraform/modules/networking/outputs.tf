output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.uat_pvt_app_subnet[*].id
}

#output "private_db_subnet_ids" {
#  value = aws_subnet.uat_pvt_db_subnet[*].id
#}
output "public_subnet_ids" {
  value = aws_subnet.uat_pub_alb_subnet[*].id
}