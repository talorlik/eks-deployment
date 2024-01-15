resource "aws_eks_addon" "vpc-cni" {
  #  depends_on   = [aws_eks_node_group.eks-node-group]
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  #  depends_on   = [aws_eks_node_group.eks-node-group]
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "coredns"
}