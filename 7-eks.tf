resource "aws_iam_role" "eks" {
  name = "${local.env}-${local.eks_name}-eks-cluster"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = "sts:AssumeRole",
      "Principal" = {
        "Service" = "eks.amazonaws.com"
      }
    }]
  })

}

resource "aws_iam_role_policy_attachment" "eks" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks" {
  name     = "${local.env}-${local.eks_name}"
  version  = local.eks_version
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.private_zone1.id,
      aws_subnet.private_zone2.id,
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks]

}

# Tyleradmin
resource "aws_eks_access_entry" "tylerawsadmin" {
  cluster_name = aws_eks_cluster.eks.name
  principal_arn = "arn:aws:iam::535002848241:user/tyleraws-admin"
}

resource "aws_eks_access_policy_association" "example" {
  cluster_name  = aws_eks_cluster.eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::535002848241:user/tyleraws-admin"

  access_scope {
    type       = "cluster"
  }
}
