resource "aws_eip" "sopas-nat" {
  vpc = true

  tags = {
    Name = "sopas-nat"
  }
}

resource "aws_nat_gateway" "sopas-nat" {
  allocation_id = aws_eip.sopas-nat.id
  subnet_id     = aws_subnet.sopa-public-us-east-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.sopas-igw]
}