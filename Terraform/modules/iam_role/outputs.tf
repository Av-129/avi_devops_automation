# modules/iam_role/outputs.tf
output "ec2_ssm_role_name" {
  value = aws_iam_role.ec2_ssm_role.name
}
