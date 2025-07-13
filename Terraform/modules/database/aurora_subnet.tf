# resource "aws_db_subnet_group" "aurora_subnet_group" {
#   name        = "abc-aurora-subnet-group"
#   description = "Subnet group for Aurora cluster"
#   subnet_ids  = var.private_db_subnet_ids
# 
#   tags = {
#     Name = "abc-aurora-subnet-group"
#   }
# }
