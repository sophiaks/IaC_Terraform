variable "ec2_count" {
    default = "2"
}

variable "ami_id" {
    default = "ami-09d56f8956ab235b3" # Ubuntu 22.04 LTS amd64
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_id" {}