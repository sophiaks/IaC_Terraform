# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.main_vpc.id
  depends_on = [
    aws_vpc.main_vpc
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
}

resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
  cidr_blocks       = ["A.B.C.D/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cluster.id}"
  to_port           = 443
  type              = "ingress"
}