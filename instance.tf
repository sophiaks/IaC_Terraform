# resource "aws_instance" "django1" {
#   ami = var.ami # Ubuntu 22.04 LTS amd64
#   instance_type = "t3.small"
#   subnet_id = "${aws_subnet.private_subnet1.id}"

#   tags = {
#     Name = "django1"
#   }
# }

# resource "aws_instance" "django2" {
#   ami = var.ami # Ubuntu 22.04 LTS amd64
#   instance_type = "t3.small"
#   subnet_id = "${aws_subnet.private_subnet2.id}"

#   tags = {
#     Name = "django2"
#   }
# }

# resource "aws_instance" "SGDB_Postgres" {
#   ami = var.ami # Ubuntu 22.04 LTS amd64
#   instance_type = "t3.small"
#   subnet_id = "${aws_subnet.public_subnet.id}"

#   tags = {
#     Name = "SGDB_Postgres"
#   }
# }