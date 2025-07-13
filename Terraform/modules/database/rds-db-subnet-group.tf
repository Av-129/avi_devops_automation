 # resource "aws_db_subnet_group" "rds-db-subnet-group" {
 #   name        = var.rds-db-subnet-group-name
 #   description = "abc DB Subnet Group"
 #   subnet_ids              = var.private_db_subnet_ids
 #   tags = {
 #     Name    = "${var.namespace}_db_subnet_group"
 #   map-dba = "divyanshu"
 #  }
 # }