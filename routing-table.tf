# Routing for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "public-route-table"
  }
}

# Routing for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "private-route-table"
  }
}

# Route for IG
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "10.0.0.0/16"
  gateway_id             = aws_internet_gateway.igw.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway1" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "10.0.0.0/16"
  nat_gateway_id         = aws_nat_gateway.nat_gateway1.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway2" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "10.0.0.0/16"
  nat_gateway_id         = aws_nat_gateway.nat_gateway2.id
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.private.id
}