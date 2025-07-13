# modules/msk/iam.tf
resource "aws_iam_role" "msk_autoscale" {
  name = "msk-autoscale-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "application-autoscaling.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "msk_autoscaling" {
  name        = "MSKAutoscalingPolicy"
  description = "Permissions for MSK storage autoscaling"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "application-autoscaling:*",
          "kafka:DescribeClusterV2",
          "kafka:UpdateBrokerStorage",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarms"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "msk_autoscale" {
  role       = aws_iam_role.msk_autoscale.name
  policy_arn = aws_iam_policy.msk_autoscaling.arn
}
