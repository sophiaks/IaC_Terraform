
resource "aws_iam_role" "sopas-iam-role" {
  name = "sopas-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "sopas-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.sopas-iam-role.name
}

resource "aws_eks_cluster" "sopas-eks" {
  name     = "sopas-eks"
  role_arn = aws_iam_role.sopas-iam-role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.sopa-private-us-east-1a.id,
      aws_subnet.sopa-private-us-east-1b.id,
      aws_subnet.sopa-public-us-east-1a.id,
      aws_subnet.sopa-public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.sopas-AmazonEKSClusterPolicy]
}