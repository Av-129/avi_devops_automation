 # #eks node group IAM role - cnb-node-group
 # 
 # resource "aws_iam_role" "eks_iam_role_nodegroup" {
 #   name        = "${var.namespace}_eks_abc_nogegroup_role"
 #   description = "IAM Role for AWS EKS Service"
 # 
 #   # Terraform's "jsonencode" function converts a
 #   # Terraform expression result to valid JSON syntax.
 # 
 # 
 #   assume_role_policy = jsonencode({
 #     "Version" : "2012-10-17",
 #     "Statement" : [
 #       {
 #         "Effect" : "Allow",
 #         "Principal" : {
 #           "Service" : "ec2.amazonaws.com"
 #         },
 #         "Action" : "sts:AssumeRole"
 #       }
 #     ]
 #     }
 #   )
 # }
 # 
 # resource "aws_iam_role_policy_attachment" "eks_policy1_nodegroup" {
 #   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 #   role       = aws_iam_role.eks_iam_role_nodegroup.name
 # }
 # 
 # resource "aws_iam_role_policy_attachment" "eks_policy2_nodegroup" {
 #   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
 #   role       = aws_iam_role.eks_iam_role_nodegroup.name
 # }
 # 
 # resource "aws_iam_role_policy_attachment" "eks_policy3_nodegroup" {
 #   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
 #   role       = aws_iam_role.eks_iam_role_nodegroup.name
 # }


# node-iam.tf
resource "aws_iam_role" "eks_iam_role_nodegroup" {
  name        = "${var.namespace}-eks-nodegroup-role"
  description = "IAM role for EKS worker nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Standard EKS Policies
resource "aws_iam_role_policy_attachment" "eks_policy1_nodegroup" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_iam_role_nodegroup.name
}

resource "aws_iam_role_policy_attachment" "eks_policy2_nodegroup" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_iam_role_nodegroup.name
}

resource "aws_iam_role_policy_attachment" "eks_policy3_nodegroup" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_iam_role_nodegroup.name
}


