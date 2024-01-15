### Create VPC ###

resource "aws_vpc" "main" {
    count                = var.create_vpc ? 1 : 0
    cidr_block           = var.vpc_cidr_block
    enable_dns_support   = true # gives you an internal domain name
    enable_dns_hostnames = true # gives you an internal host name

    tags = {
        Name = "main"
    }
}

### Create Internet Gateway ###

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main[0].id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-ig" })
  )
}

### Create Private and Public Subnets on multiple AZs ####

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    tomap({ "Name" = "${var.prefix}-pvt${count.index}-${var.azs[count.index]}" }),
    tomap({ "kubernetes.io/role/internal-elb" = "1" }),
    tomap({ "kubernetes.io/cluster/${var.cluster_name}" = "owned" })
  )
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    tomap({ "Name" = "${var.prefix}-pub${count.index}-${var.azs[count.index]}" }),
    tomap({ "kubernetes.io/role/elb" = "1" }),
    tomap({ "kubernetes.io/cluster/${var.cluster_name}" = "owned" })
  )
}

### Create NAT Gateway ###

resource "aws_eip" "main" {
  domain = "vpc"
  tags = merge(
    tomap({ "Name" = "${var.prefix}-eip" })
  )
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id = element(aws_subnet.public.*.id, 1)

  tags = merge(
    tomap({ "Name" = "${var.prefix}-nat" })
  )

  depends_on = [aws_internet_gateway.main]
}

### Create Routing Tables, Routes and Associations ###

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main[0].id
  tags   = merge(
    tomap({ "Name" = "${var.prefix}-private-rt" })
  )
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main[0].id
  tags   = merge(
    tomap({ "Name" = "${var.prefix}-public-rt" })
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}
