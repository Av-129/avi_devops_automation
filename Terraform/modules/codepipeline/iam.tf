 locals {
   pipelines_map = { for p in var.pipelines : p.name => p }
 }

# modules/cicd/iam.tf

# data "aws_iam_policy_document" "codebuild_assume_role" {
#   statement {
#     effect = "Allow"
#     principals {
#       type        = "Service"
#       identifiers = ["codebuild.amazonaws.com"]
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "codebuild_role" {
#   name               = "global-codebuild-role-2"
#   assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
# }
# 
# resource "aws_iam_role_policy" "codebuild_policy" {
#   name = "global-codebuild-policy"
#   role = aws_iam_role.codebuild_role.id
#   policy = jsonencode({
#     Version   = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "ecr:GetAuthorizationToken",
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "secretsmanager:GetSecretValue",
#           "secretsmanager:DescribeSecret"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }


# ##############################
# # CodePipeline IAM Role & Policy
# ##############################
 # data "aws_iam_policy_document" "codepipeline_assume_role" {
 #   statement {
 #     effect = "Allow"
 #     principals {
 #       type        = "Service"
 #       identifiers = ["codepipeline.amazonaws.com"]
 #     }
 #     actions = ["sts:AssumeRole"]
 #   }
 # }
 # 
 # resource "aws_iam_role" "codepipeline_role" {
 #   for_each = { for p in var.pipelines : p.name => p }
 #   name     = "${each.value.name}-codepipeline-role"
 #   assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
 # }
 # 
 # resource "aws_iam_role_policy" "codepipeline_policy" {
 #   for_each = aws_iam_role.codepipeline_role
 #   name     = "${each.key}-policy"
 #   role     = each.value.id
 #   policy   = jsonencode({
 #     Version = "2012-10-17",
 #     Statement = [
 #       {
 #         Effect = "Allow",
 #         Action = [
 #           "s3:GetObject",
 #           "s3:GetObjectVersion",
 #           "s3:GetBucketVersioning",
 #           "s3:PutObject",
 #           "s3:PutObjectAcl"
 #         ],
 #         Resource = "*"
 #       },
 #       {
 #         Effect   = "Allow",
 #         Action   = ["codestar-connections:UseConnection"],
 #         Resource = local.pipelines_map[each.key].codestar_connection_arn
 #       },
 #       {
 #         Effect = "Allow",
 #         Action = [
 #           "codebuild:StartBuild",
 #           "codebuild:BatchGetBuilds"
 #         ],
 #         Resource = "*"
 #       }
 #     ]
 #   })
 # }


