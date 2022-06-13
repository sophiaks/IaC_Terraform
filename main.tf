module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_id = "${aws_vpc.main_vpc.id}"
  tenancy = "default"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  enable_nat_gateway   = true
}

module "eks" {
  source = "./modules/eks"
  version = "~> 18.0"

  cluster_name    = "sopas-cluster"
  cluster_version = "1.21"

  vpc_id     = modules.vpc.id
  // TODO: Add subnets
  subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
}