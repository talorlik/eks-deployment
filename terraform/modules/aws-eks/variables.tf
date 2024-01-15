variable "prefix" {
  default = "prefix"
}

variable "project" {
  default = "project_name"
}

variable "application" {
  default = "application"
}

variable "k8s_version" {
    description = "Required K8s version"
    type        = string
    default     = "1.28"
}

variable "cluster_iam_role_name" {
    description = "The name of the iam role to deploy for the cluster"
    type        = string
    default     = "cluster-iam-role"
    nullable    = false
}

variable "node_iam_role_name" {
    description = "The name of the iam role to deploy for the nodes"
    type        = string
    default     = "node-iam-role"
    nullable    = false
}

variable "cluster_name" {
    description = "The name of the eks cluster to deploy"
    type        = string
    default     = "main"
    nullable    = false
}

variable "endpoint_private_access" {
    description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
    type        = bool
    default     = true
}

variable "aws_region" {
    description = "The region to use for the deployment"
    type        = string
    default     = "us-east-1"
}

variable "endpoint_public_access" {
    description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
    type        = bool
    default     = false
}

variable "eks_cw_logging" {
  description = "Enable EKS CWL for EKS components"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "instance_types" {
    description = "Allowed Instance Types"
    type        = list(string)
    default     = ["t2.medium", "t3.medium"]
}

variable "node_instance_type" {
    description = "Launch Template Instance Types"
    type        = string
    default     = "t3.medium"
}

variable "desired_capacity" {
    description = "How many instances are needed"
    type        = number
    default     = 1
}

variable "max_size" {
    description = "Min allowed instances"
    type        = number
    default     = 5
}

variable "min_size" {
    description = "Max allowed instances"
    type        = number
    default     = 1
}

variable "max_unavailable" {
    description = "Max unavailable instances"
    type        = number
    default     = 1
}

variable "vpc_id" {
    description = "The VPC ID"
    type = string
}

variable "vpc_cidr_block" {
    description = "The CIDR Block for the IP ranges for the VPC"
    type        = string
}

variable "subnet_ids" {}
variable "private_subnets" {}
variable "vpc_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "aws_iam" {}