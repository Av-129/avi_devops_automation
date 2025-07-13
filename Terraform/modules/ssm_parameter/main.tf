resource "aws_ssm_parameter" "secrets" {
  for_each    = var.secrets

  name        = each.value.name
  description = each.value.description
  type        = each.value.type
  value       = each.value.value
  key_id      = each.value.type == "SecureString" ? each.value.key_id : null
  tier        = "Standard"
  # overwrite   = true
  tags        = var.common_tags
}
