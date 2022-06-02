resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "${var.tenancy}"
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name = "main_vpc"
    }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "igw"
  }
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.id]
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name = "nat"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = "${var.vpc_id}"
    count = length(var.public_subnets_cidr)
    cidr_block = element(var.public_subnets_cidr, count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "${element(var.availability_zones, count.index)}-public-subnet"
    }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = length(var.private_subnets_cidr)
    cidr_block = element(var.private_subnets_cidr,count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = false

    tags = {
        Name = "${element(var.availability_zones, count.index)}-private-subnet"
    }
}

# Routing for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "private-route-table"
  }
}

# Routing for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "public-route-table"
  }
}

# Route for IG
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}



