variable "artifact_bucket" {
  description = "Name of the shared S3 bucket for CodePipeline artifacts (from the buckets-app module)"
  type        = string
  default     = "shared-artifact-bucket"  // This default can be overridden in the root module.
}

variable "pipelines" {
  description = "List of pipeline definitions for CodePipeline and CodeBuild"
  type = list(object({
    # CodePipeline settings
    name                    = string  // Unique pipeline name
    repository              = string  // GitHub repository in "owner/repo" format
    branch                  = string  // Branch name
    codestar_connection_arn = string  // ARN for the CodeStar connection

    # CodeBuild settings
    build_project_name         = string // Unique CodeBuild project name
    build_project_description  = string // Description for the CodeBuild project
    buildspec                  = string // Path to the buildspec file
    build_timeout              = number // Build timeout in minutes
    codebuild_compute_type     = string // e.g., "BUILD_GENERAL1_SMALL" or "BUILD_GENERAL1_MEDIUM"
    codebuild_image            = string // e.g., "aws/codebuild/amazonlinux-aarch64-standard:3.0"
    codebuild_environment_type = string // e.g., "LINUX_CONTAINER"

    # Environment variables for CodeBuild.
    environment_variables = list(object({
      name  = string
      value = string
      type  = string // e.g., "PLAINTEXT" or "SECRETS_MANAGER"
    }))
 }))
 default = [
      {
       name                    = "service"
       repository              = "github/abc"
       branch                  = "v1"
       codestar_connection_arn = "arn:aws:codeconnections:ap-south-1:353346:connection/85eaf9f7-269f-4454-a92f-58d0fbf4b595"
       
       build_project_name         = "service"
       build_project_description  = "Build project for lpdd-prod-nms-bridge-service"
       buildspec                  = "./devops/buildspec.yaml"
       build_timeout              = 60
   codebuild_compute_type     = "BUILD_GENERAL1_SMALL"
    codebuild_image            = "aws/codebuild/amazonlinux-aarch64-standard:3.0"
    codebuild_environment_type = "ARM_CONTAINER" 
 
 
       
       environment_variables = [
         { name = "CLUSTER_NAME", value = "ipv6-eks", type = "PLAINTEXT" },
         { name = "AWS_ACCOUNT", value = "3346", type = "PLAINTEXT" },
         { name = "REPOSITORY_URI", value = "53346.dkr.ecr.ap-south-1.amazonaws.com", type = "PLAINTEXT" }
       ]
     },


   #// Add additional pipeline objects here for 100+ pipelines.
  ]
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "secret_arn" {
  description = "Fallback secret ARN to use if SECRET_ARN is empty in environment variables"
  type        = string
  default     = "arn:aws:secretsmanager:ap-south-1:92253346:secret:my-secret"
}



variable "common_tags" {
  type = map(string)
  default = {
    map-migrated = "**"
  }
}

