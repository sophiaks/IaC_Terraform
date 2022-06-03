variable "azs" {
  description = "AWS Regions"
  type = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private-subnets" {
  description = "Private Subnet CIDR"
  type = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public-subnets" {
  description = "Public Subnet CIDR"
  type = list(any)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}