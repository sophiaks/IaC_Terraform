resource "aws_vpc" "vpc" {
  
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  enable_classiclink = "false"
  instance_tenancy = "default" # Instance tenacy means ec2 will be the only instance

  tags = { 
    "Name" = "vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = 2

  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnets"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private_subnets"
  }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags = {
        Name = "igw"
    }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "table_assoc_pub" {
  count = 2

  subnet_id      = "${aws_subnet.public_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_route_table_association" "table_assoc_pr" {
  count = 2

  subnet_id      = "${aws_subnet.private_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.route_table.id}"
}