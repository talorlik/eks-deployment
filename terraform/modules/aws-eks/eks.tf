### Create the EKS Cluster ###

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.k8s_version
  role_arn = aws_iam_role.cluster-iam-role.arn

  vpc_config {
    security_group_ids      = [aws_security_group.cluster-sg.id]
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  enabled_cluster_log_types = var.eks_cw_logging

  tags = {
    Name = "main"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-iam-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-iam-role-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.cluster-iam-role-AmazonEKSVPCResourceController,
  ]
}
