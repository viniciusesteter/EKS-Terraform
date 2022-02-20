# Cluster initial setup
resource "aws_eks_cluster" "k8s_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.k8s-eks-cluster-role.arn
  version  = "1.21"

  tags = var.tags

  vpc_config {
    subnet_ids = var.eks_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.k8s-AmazonEKSServicePolicy,
  ]
}