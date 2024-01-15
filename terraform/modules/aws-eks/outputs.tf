output "aws_region" {
  value = var.aws_region
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "ca" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster-sg" {
  value = aws_security_group.cluster-sg.id
}

output "node-sg" {
  value = aws_security_group.node-sg.id
}

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.node-iam-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.main.certificate_authority.0.data}
    server: ${aws_eks_cluster.main.endpoint}
  name: ${aws_eks_cluster.main.arn}
contexts:
- context:
    cluster: ${aws_eks_cluster.main.arn}
    user: ${aws_eks_cluster.main.arn}
  name: ${aws_eks_cluster.main.arn}
current-context: ${aws_eks_cluster.main.arn}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.main.arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - ${var.aws_region}
      - eks
      - get-token
      - --cluster-name
      - ${aws_eks_cluster.main.name}
      - --output
      - json
      command: aws
KUBECONFIG
}

output "config_map_aws_auth" {
  value = "local.config-map-aws-auth"
}

output "kubeconfig" {
  value = "local.kubeconfig"
}

resource "local_file" "kube_config_file" {
  content  = local.kubeconfig
  filename = "config"
}

resource "local_file" "aws-auth-cm" {
  content  = local.config-map-aws-auth
  filename = "aws-auth-cm.yml"
}

output "eks_cluster_autoscaler_arn" {
  value = aws_iam_role.eks_cluster_autoscaler.arn
}