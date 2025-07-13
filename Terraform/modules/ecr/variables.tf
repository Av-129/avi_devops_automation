variable "ecr_repository_names" {
  description = "List of ECR repositories to create"
  type        = list(string)
  default     = [ "lpdd/prod/hes-v2/command-dispatcher-service",
  "abc"
] # Modify this list to add more repos
}

variable "image_tag_mutability" {
  description = "The tag mutability for images in the repository."
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "Tags for ECR repositories."
  type        = map(string)
  default     = {
    "map-migrated" = "**",
    "Environment" = "PROD"
    "ManagedBy"   = "Terraform"
  }
}

# variable "ecr_repository_policy" {
#   description = "JSON policy for ECR repositories"
#   type        = string
#   default     = ""  # If empty, a default policy will be applied
# }
