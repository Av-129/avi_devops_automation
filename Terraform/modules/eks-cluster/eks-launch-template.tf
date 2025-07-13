
  
  resource "aws_launch_template" "amazon-eks" {
    name                   = "${var.namespace}-amazon-eks-linux-template"
    default_version        = var.launch_template_version
    vpc_security_group_ids = [var.security_group_id]
    metadata_options {
      http_endpoint               = "enabled"
      http_put_response_hop_limit = 3
      http_tokens                 = "required"
    }
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name                             = "${var.namespace}_pvt_eks_node"
        map-migrated                     = "mig70U3Z9VNAJ"
        "alpha.eksctl.io/nodegroup-name" = "${var.namespace}_pvt_node_group"
        "alpha.eksctl.io/nodegroup-type" = "managed"
      }
    }
    tag_specifications {
      resource_type = "volume"
      tags = {
        Name                             = "${var.namespace}_pvt_eks_node_voulume"
        map-migrated                     = "mig70U3Z9VNAJ"
        "alpha.eksctl.io/nodegroup-name" = "${var.namespace}_pvt_node_group"
        "alpha.eksctl.io/nodegroup-type" = "managed"
      }
    }
    tag_specifications {
      resource_type = "network-interface"
      tags = {
        Name                             = "${var.namespace}_pvt_eks_node_interface"
        map-migrated                     = "**"
        "alpha.eksctl.io/nodegroup-name" = "${var.namespace}_pvt_node_group"
        "alpha.eksctl.io/nodegroup-type" = "managed"
      }
    }
  
    block_device_mappings {
      device_name = "/dev/xvda"
      ebs {
        volume_size = "50"
        volume_type = "gp3"
  
      }
    }
    image_id = var.ami_id
   user_data = base64encode(<<-EOF
 
 #!/bin/bash
 set -o xtrace
 /etc/eks/bootstrap.sh ${var.cluster_name}
   EOF
   )
 }

