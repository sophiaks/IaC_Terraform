resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  enable_classiclink = "false"
  instance_tenancy = "default" # Instance tenacy means ec2 will be the only instance

  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1a"


  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1b"

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "false"

  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"

  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags = {
        Name = "igw"
    }
}

resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "gw NAT 1"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gateway2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name = "gw NAT 2"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip1" {
  vpc = true

  tags = {
    Name = "eip 1"
  }

  associate_with_private_ip = "10.0.3.0"
  depends_on                = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip2" {
  vpc = true

  tags = {
    Name = "eip 2"
  }

  associate_with_private_ip = "10.0.4.0"
  depends_on                = [aws_internet_gateway.igw]
}