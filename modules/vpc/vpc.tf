module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "sopas-vpc"
  cidr = "10.0.0.0/16"

  azs             = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  enable_nat_gateway = true
  single_nat_gateway  = false
  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  enable_vpn_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_eip" "nat" {
  count = 3
  vpc = true
}