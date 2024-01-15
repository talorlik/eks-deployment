variable "prefix" {
  default = "prefix"
}

variable "project" {
  default = "project_name"
}

variable "application" {
  default = "application"
}

variable "aws_region" {
    description = "The region to use for the deployment"
    type        = string
    default     = "us-east-1"
}

variable "azs" {
    description = "A list of availability zones"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster_name" {
    description = "The name of the eks cluster to deploy"
    type        = string
    default     = "main"
    nullable    = false
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_cidr_block" {
    description = "The CIDR Block for the IP ranges for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
    description = "The CIDR Blocks for the Private Subnet IP ranges for the VPC"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidr" {
    description = "The CIDR Blocks for the Public Subnet IP ranges for the VPC"
    type        = list(string)
    default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "enable_nat_gateway" {
    description = "Wether to enable the NAT Gateway"
    type = bool
    default = true
}

variable "public_eks_tag" {
  description = "tag needed for eks"
  type        = map(any)
}

variable "private_eks_tag" {
  description = "tag needed for eks"
  type        = map(any)
}