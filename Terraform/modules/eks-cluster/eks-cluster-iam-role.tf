#eks IAM Role for cluster

resource "aws_iam_role" "eks_iam_role" {
  name        = "${var.namespace}_eks_iam_role"
  description = "IAM Role for AWS EKS Service for cluster"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
    }
  )
}


#attach eks policy on role

resource "aws_iam_role_policy_attachment" "eks_policy1_attachement" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_iam_role.name
}

# resource "aws_iam_role_policy_attachment" "eks_policy2_attachement" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks_iam_role.name
# }

resource "aws_iam_role_policy_attachment" "eks_policy3_attachement" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_policy4_attachement" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_iam_role.name
}