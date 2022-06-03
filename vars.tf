variable "AWS_REGION" {
    description = "AWS deployment region."
    default = "us-east-1"
}

variable "azs" {
  description = "AWS Regions"
  type = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "Private Subnet CIDR"
  type = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public Subnet CIDR"
  type = list(any)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "ami_ubuntu" {
    description = "Ubuntu 20.04 Image"
    default = ""
}