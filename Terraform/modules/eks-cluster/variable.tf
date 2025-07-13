variable "cluster_name" {
  description = "Enter the EKS Cluster Name"
  default     = "abc-cluster"
}

variable "namespace" {
  default = "abc"
}



#variable "key_name" {
#  default  = "abc_pvt_eks_app_key"
#  nullable = false
#}

variable "ami_id" {
  default  = "ami-0431db82d7dc815dd"
  nullable = false
}


variable "runtime_node_disk_size" {
  default  = "50"
  nullable = false
}


variable "security_group_id" {
 description = "Security Group ID for EKS Nodes"
  type        = string

}


variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}


variable "launch_template_version" {
  default  = "1"
  nullable = false
}