#eks cluster


resource "aws_eks_cluster" "eks_cluster" {
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks_iam_role.arn
  tags                      = {}
  tags_all                  = {}
  version                   = "1.31"
  kubernetes_network_config {
    ip_family         = "ipv6"
  }
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true  # this should be false for production and if your popeline is in different accound and your deployment is in different account then you need to true it so that code build can access the eks
    public_access_cidrs     = ["0.0.0.0/0"]
   # public_access_cidrs     = ["::/0"]  # Allow IPv6 public access
    security_group_ids      = [var.security_group_id]
    subnet_ids      = var.private_subnet_ids
  }
  depends_on = [aws_iam_role.eks_iam_role]
}


 resource "aws_eks_addon" "eks_addon" {
   cluster_name                = aws_eks_cluster.eks_cluster.name
   addon_name                  = "vpc-cni"
   addon_version               = "v1.19.5-eksbuild.3"
   resolve_conflicts_on_update = "OVERWRITE"
 }

 resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.4-eksbuild.14" # Replace with latest compatible version
  resolve_conflicts_on_update = "OVERWRITE"
}


resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.31.7-eksbuild.7" # Replace with latest compatible version
  resolve_conflicts_on_update = "OVERWRITE"
}


#resource "aws_eks_addon" "ebs_csi_driver" {
#  cluster_name                = aws_eks_cluster.eks_cluster.name
#  addon_name                  = "aws-ebs-csi-driver"
#  addon_version               = "v1.31.0-eksbuild.1" # Replace with latest compatible version
#  resolve_conflicts_on_update = "OVERWRITE"
#}

