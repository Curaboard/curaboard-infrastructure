resource "aws_eks_cluster" "prod_cluster" {
  name     = var.eks_repo_name
  role_arn = aws_iam_role.eks_iam_role.arn

  vpc_config {
    subnet_ids = [var.subnet_id1, var.subnet_id2, var.subnet_id3]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_iam_role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_iam_role-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.eks_iam_role-AmazonEC2ContainerRegistryReadOnly-EKS
    # aws_cloudwatch_log_group.monitor_prod_cluster
  ]

  enabled_cluster_log_types = ["api", "audit"]

  tags = {
    "project" = "streambix"
  }
}

## Worker Nodes
resource "aws_eks_node_group" "prod_cluster_node_group" {
  cluster_name    = aws_eks_cluster.prod_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = [var.subnet_id1, var.subnet_id2, var.subnet_id3]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.workernodes_iam_role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.workernodes_iam_role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.workernodes_iam_role-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    "project" = "streambix"
  }
}