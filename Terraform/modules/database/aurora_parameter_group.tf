# resource "aws_db_parameter_group" "aurora_pg" {
#   name   = "abc-aurora-parameter-group"
#   family = "aurora-postgresql15"
# 
#   parameter {
#     name  = "log_connections"
#     value = "1"
#   }
# 
#   parameter {
#     name  = "log_disconnections"
#     value = "1"
#   }
# 
# 
#   tags = {
#     Name = "abc-aurora-parameter-group"
#   }
# }
