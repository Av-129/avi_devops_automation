 # # #Amazon ElastiCache Paraemeter Group - Redis
 
 
  resource "aws_elasticache_parameter_group" "abc_redis" {
    name        = "abc-elasticache-redis"
    family      = "redis7"
    description = "ElastiCache Redis Parameter Group"
  
    parameter {
      name  = "cluster-enabled"
      value = "yes"
    }
    tags = {
      map-dba = "divyanshu"
    }
  }