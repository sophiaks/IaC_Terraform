# Module returns vpc_id
output "vpc_id" {
    value = "${aws_vpc.main_vpc.id}"
}

# Module returns public subnets_id
output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

# Module returns private subnets_id
output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "default_sg_id" {
  value = aws_security_group.default.id
}

output "security_groups_ids" {
  value = ["${aws_security_group.default.id}"]
}

output "public_route_table" {
  value = aws_route_table.public.id
}