variable "AWS_REGION" {
    default = "us-east-1"
}

variable "cluster-name" {
  default = "eks-cluster"
  type    = string
}

variable "ami" {
  default = "ami-09d56f8956ab235b3"
  type    = string
}