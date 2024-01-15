output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.main[0].*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.main[0].*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.main[0].*.cidr_block, [""])[0]
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = concat(aws_vpc.main[0].*.default_security_group_id, [""])[0]
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = concat(aws_vpc.main[0].*.default_route_table_id, [""])[0]
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_vpc.main[0].*.instance_tenancy, [""])[0]
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.main[0].*.enable_dns_support, [""])[0]
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.main[0].*.enable_dns_hostnames, [""])[0]
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with main VPC"
  value       = concat(aws_vpc.main[0].*.main_route_table_id, [""])[0]
}

output "subnet_ids" {
  description = "All the subnet IDs"
  value = concat(aws_subnet.private.*.id, aws_subnet.public.*.id)
}

output "private_subnets" {
  description = "All the private subnet IDs"
  value = aws_subnet.private.*.id
}

output "public_subnets" {
  description = "All the public subnet IDs"
  value = aws_subnet.public.*.id
}

output "private_subnets_cidr" {
  description = "The private vpc subnets cidr"
  value       = aws_subnet.private.*.cidr_block
}

output "public_subnets_cidr" {
  description = "The public vpc subnets cidr"
  value       = aws_subnet.public.*.cidr_block
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.main.id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.main.*.public_ip
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.main.*.id, [""])[0]
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = concat(aws_internet_gateway.main.*.arn, [""])[0]
}