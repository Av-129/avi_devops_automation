output "codebuild_project_arns" {
  value = { for key, proj in aws_codebuild_project.build_project : key => proj.arn }
}


output "codepipeline_ids" {
  value = { for key, cp in aws_codepipeline.pipeline : key => cp.id }
}

