
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-ssm-instance-profile"
  role = var.iam_role_name
  
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
 iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Test-EC2"
  }
}
