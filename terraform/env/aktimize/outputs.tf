output "aws_region" {
  description = "The region into which the deplyment of the EKS Cluster was done."
  value = module.eks.aws_region
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "subnet_ids" {
  description = "All the subnet IDs"
  value = module.vpc.subnet_ids
}

output "private_subnets" {
  description = "All the private subnet IDs"
  value = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "cluster-sg" {
  value = module.sg.cluster-sg
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}