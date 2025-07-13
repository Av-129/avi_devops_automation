 # # eks node
 # resource "aws_eks_node_group" "abc-eks-node-group" {
 #   capacity_type  = "ON_DEMAND"
 #   cluster_name   = aws_eks_cluster.eks_cluster.id
 #   instance_types = ["t3.large"]
 #   labels = {
 #     project = "abc"
 #     type    = "${var.namespace}-worker-node"
 #   }
 # 
 #   node_group_name = "${var.namespace}_eks_pvt_node_group"
 #   node_role_arn   = aws_iam_role.eks_iam_role_nodegroup.arn
 #   # subnet_ids      = ["subnet-04c1723270ca11c8d", "subnet-063486e05458cfe38"]
 #   subnet_ids              = var.private_subnet_ids
 #   # ami_type        = var.ami_type
 #   tags = {
 #     Name = "${var.namespace}_pvt_eks_node"
 #   }
 #   tags_all = {
 #     Name = "${var.namespace}_pvt_eks_node"
 #   }
 # # launch_template {
 # #   id    = aws_launch_template.amazon-eks.id
 # #   version = "$Latest"
 # # }
 #   scaling_config {
 #     desired_size = 1
 #     max_size     = 2
 #     min_size     = 1
 #   }
 # 
 #   update_config {
 #     max_unavailable = 1
 #   }
 # }



  # node-group.tf
  resource "aws_eks_node_group" "abc-eks-node-grouP" {
  cluster_name   = aws_eks_cluster.eks_cluster.id
  instance_types = ["c7g.xlarge"]

    capacity_type   = "ON_DEMAND"
       labels = {
      project = "abc"
      type    = "${var.namespace}-worker-node"
    }
  
    node_group_name = "${var.namespace}-node-group"
    node_role_arn   = aws_iam_role.eks_iam_role_nodegroup.arn
    subnet_ids      = var.private_subnet_ids
  tags = {
    Name = "${var.namespace}_pvt_eks_node"
  }
  tags_all = {
    Name = "${var.namespace}_pvt_eks_node"
  }
  launch_template {
    name    = aws_launch_template.amazon-eks.name
    version = "1"
  }
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
  }