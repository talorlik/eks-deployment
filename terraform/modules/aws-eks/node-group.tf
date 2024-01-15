resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node-iam-role.arn
  subnet_ids      = var.private_subnets
  capacity_type   = "ON_DEMAND"
  instance_types  = var.instance_types
  depends_on = [
    aws_eks_cluster.main,
    aws_launch_template.lt-eks-ng,
    aws_iam_role_policy_attachment.node-iam-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-iam-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-iam-role-AmazonEC2ContainerRegistryReadOnly,
  ]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  launch_template {
    name    = aws_launch_template.lt-eks-ng.name
    version = aws_launch_template.lt-eks-ng.latest_version
  }

  # Kubernetes labels
  labels = {
    "eks/cluster-name"   = aws_eks_cluster.main.name
    "eks/nodegroup-name" = format("%s-node-group", aws_eks_cluster.main.name)
  }

  tags = {
    "eks/cluster-name"                            = aws_eks_cluster.main.name
    "eks/nodegroup-name"                          = format("%s-node-group", aws_eks_cluster.main.name)
    "eks/nodegroup-type"                          = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = aws_eks_cluster.main.name
    "Name"                                        = "eks-node-group"
    "ManagedBy"                                   = "Terraform"
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}