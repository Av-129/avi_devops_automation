locals {
  common_tags = {
    map-migrated = "**",
    Env = "Prod",
    Project = "PROD"
  }

  # Map: original build_project_name -> sanitized name
  sanitized_build_names = {
    for p in var.pipelines : p.build_project_name =>
    replace(trim(p.build_project_name, "/"), "/", "-")
  }

  # Map: original pipeline name -> sanitized name
  sanitized_pipeline_names = {
    for p in var.pipelines : p.name =>
    replace(trim(p.name, "/"), "/", "-")
  }
}

##########################
# CodeBuild Project
##########################
resource "aws_codebuild_project" "build_project" {
  for_each = {
    for p in var.pipelines : local.sanitized_build_names[p.build_project_name] => p
  }

  name          = each.key
  description   = each.value.build_project_description
  build_timeout = each.value.build_timeout
  service_role  = "arn:aws:iam::2253346:role/codebuild-role"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = each.value.codebuild_compute_type
    image        = each.value.codebuild_image
    type         = each.value.codebuild_environment_type

    dynamic "environment_variable" {
      for_each = each.value.environment_variables
      content {
        name  = environment_variable.value.name
        value = (environment_variable.value.name == "SECRET_ARN" && environment_variable.value.value == "") ? var.secret_arn : environment_variable.value.value
        type  = (environment_variable.value.name == "SECRET_ARN" && environment_variable.value.value == "") ? "SECRETS_MANAGER" : environment_variable.value.type
      }
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = each.value.buildspec
  }

  tags = local.common_tags
}


##########################
# CodePipeline
##########################
resource "aws_codepipeline" "pipeline" {
  for_each = {
    for p in var.pipelines : local.sanitized_pipeline_names[p.name] => p
  }

  name     = each.key
  role_arn = "arn:aws:iam::53346:role/codepipeline-role-lpdd"
  pipeline_type = "V2"

  artifact_store {
    type     = "S3"
    location = var.artifact_bucket
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = each.value.codestar_connection_arn
        FullRepositoryId = each.value.repository
        BranchName       = each.value.branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.build_project[local.sanitized_build_names[each.value.build_project_name]].name
      }
    }
  }

  tags = local.common_tags
}

