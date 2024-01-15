variable "prefix" {}
variable "project" {}
variable "application" {}
variable "aws_region" {}
variable "create_vpc" {}
variable "cluster_name" {}
variable "vpc_cidr_block" {}
variable "azs" {
  description = "A list of availability zones"
  type        = list(string)
}
variable "public_subnet_cidr" {
  description = "A list of the public subnets' cidr"
  type        = list(string)
}
variable "private_subnet_cidr" {
  description = "A list of the private subnets' cidr"
  type        = list(string)
}
variable "enable_nat_gateway" {}
variable "k8s_version" {}
variable "node_instance_type" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "max_unavailable" {}
variable "endpoint_private_access" {}
variable "endpoint_public_access" {}
variable "eks_cw_logging" {}

variable "public_eks_tag" {
  description = "tag needed for eks"
  type        = map(any)
}
variable "private_eks_tag" {
  description = "tag needed for eks"
  type        = map(any)
}

variable "aws_iam" {}