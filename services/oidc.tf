data "aws_eks_cluster" "prod_cluster" {
  name = var.eks_repo_name
}

data "tls_certificate" "eks_oidc" {
  url = data.aws_eks_cluster.prod_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_openid_connect_provider" "eks_oidc_connect_provider" {
  arn = "arn:aws:iam::883445774713:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/2F7601F6A363D848EBB684B85404E5D1"
}