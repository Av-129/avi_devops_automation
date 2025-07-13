# #Creating an IAM OIDC provider for your cluster

# #fetch the data for thumbprint_list


# data "tls_certificate" "thumblist" {
#   url = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
# }
# 
# #openidc provider
# 
# resource "aws_iam_openid_connect_provider" "iam_eks_open_id" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.thumblist.certificates.0.sha1_fingerprint]
#   url             = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
# }