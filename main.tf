terraform {
  # Setting Provider (AWS)
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.13.0"
    }
  }
}

resource "aws_instance" "django1" {
  ami = "ami-09d56f8956ab235b3" # Ubuntu 22.04 LTS amd64
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.public_subnets.*.id[count.index]}"

  tags = {
    Name = "django1"
  }
}

resource "aws_instance" "django2" {
  ami = "ami-09d56f8956ab235b3" # Ubuntu 22.04 LTS amd64
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.public_subnets.*.id[count.index]}"

  tags = {
    Name = "django2"
  }
}

resource "aws_instance" "SGDB_Postgres" {
  ami = "ami-09d56f8956ab235b3" # Ubuntu 22.04 LTS amd64
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.public_subnets.*.id[count.index]}"

  tags = {
    Name = "SGDB_Postgres"
  }
}
# Synthax for resources:
# resource "<provider>_<resource_type>" "name"