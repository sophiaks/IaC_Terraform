resource "aws_internet_gateway" "sopas-igw" {
  vpc_id = aws_vpc.sopas-vpc.id

  tags = {
    Name = "sopas-igw"
  }
}