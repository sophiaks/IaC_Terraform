provider "aws" {
    region = "us-east-1"
    // shared_credentials_files = ["~/.aws/credentials"]
    shared_credentials_file = "C:/Users/sophi/.aws/creds"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}