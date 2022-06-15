resource "aws_route_table" "sopas-private-table" {
  vpc_id = aws_vpc.sopas-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.sopas-nat.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "sopas-private-table"
  }
}

resource "aws_route_table" "sopas-public-table" {
  vpc_id = aws_vpc.sopas-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.sopas-igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "sopas-public-table"
  }
}

resource "aws_route_table_association" "sopas-private-us-east-1a" {
  subnet_id      = aws_subnet.sopa-private-us-east-1a.id
  route_table_id = aws_route_table.sopas-private-table.id
}

resource "aws_route_table_association" "sopas-private-us-east-1b" {
  subnet_id      = aws_subnet.sopa-private-us-east-1b.id
  route_table_id = aws_route_table.sopas-private-table.id
}

resource "aws_route_table_association" "sopas-public-us-east-1a" {
  subnet_id      = aws_subnet.sopa-public-us-east-1a.id
  route_table_id = aws_route_table.sopas-public-table.id
}

resource "aws_route_table_association" "sopas-public-us-east-1b" {
  subnet_id      = aws_subnet.sopa-public-us-east-1b.id
  route_table_id = aws_route_table.sopas-public-table.id
}