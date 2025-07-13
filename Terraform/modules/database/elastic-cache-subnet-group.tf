 # # #ElastiCache Subnet Group
 
  resource "aws_elasticache_subnet_group" "ec_subnet_group" {
    name        = var.elsticache-subnet-group-name
    description = "ElastiCache Subnet Group"
    subnet_ids              = var.private_db_subnet_ids
    tags = {
      map-dba = "divyanshu"
    }
  }