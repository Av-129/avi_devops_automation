output "parameters" {
  description = "Map of created SSM parameters with their names and ARNs."
  value = {
    for key, param in aws_ssm_parameter.secrets :
    key => {
      name = param.name,
      arn  = param.arn
    }
  }
}
