# resource "aws_ecr_repository_policy" "this" {
#   for_each   = aws_ecr_repository.this
#   repository = each.value.name
# 
#   policy = var.ecr_repository_policy != "" ? var.ecr_repository_policy : jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "AllowPushPull"
#         Effect    = "Allow"
#         Principal = {
#           AWS = [
#             "arn:aws:iam::975050019771:root",
#             "arn:aws:iam::891377147631:root",
#             "arn:aws:iam::879381272867:root"
#           ]
#         }
#         Action = [
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:BatchGetImage",
#           "ecr:CompleteLayerUpload",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:InitiateLayerUpload",
#           "ecr:PutImage",
#           "ecr:UploadLayerPart"
#         ]
#       }
#     ]
#   })
# }
