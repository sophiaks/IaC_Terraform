module "sopa_vpc" {
    source = "./modules/vpc"
    vpc_cidr = "10.0.0.0/16"
    vpc_id = "${aws_vpc.main_vpc.id}"
    tenancy = "default"
    public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones = ["us-east-1", "us-west-1"]
}

module "sopa_ec2" {
    source = "./modules/ec2"
    ec2_count = 2
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public_subnet.*.id}"
}