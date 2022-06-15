## VPC ##
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "sopas-vpc"
  cidr = "10.0.0.0/16"

  azs             = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  enable_dns_support = true
  enable_dns_hostnames = true
  enable_nat_gateway = true
  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  enable_vpn_gateway = true
  
  tags = {
    Name = "sopas-vpc"
  }
}

## NAT ##

resource "aws_eip" "nat" {
  count = 3
  vpc = true
}

## EKS ##

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "sopas-cluster"
  cluster_version = "1.21"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.small"]
  }
    eks_managed_node_groups = {
      sopa = {
        min_size     = 3
        max_size     = 3
        desired_size = 3

        subnet_ids = module.vpc.private_subnets
        ami_id = "${var.ami_ubuntu}"

        instance_types = ["t3.small", "t2.small", "t2.micro"]
      }
    }
  

  # aws-auth configmap
  manage_aws_auth_configmap = true
}

## SECURITY GROUP ##

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

## IAM ROLE ##

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  create_role = true
  number_of_custom_role_policy_arns = 2
  role_name         = "iam-role"
}