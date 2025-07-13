resource "aws_ecr_repository" "this" {
  for_each             = toset(var.ecr_repository_names)  # Loops over the list
  name                 = each.value  # Creates a repo for each name
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags
}
