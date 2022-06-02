variable "tenancy" {
    default = "dedicated"
}

variable "vpc_id" {
    default = ""
}

variable "subnet_cidr" {
    default = "10.0.1.0/16"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "availability_zones" {
  type        = list(any)
}