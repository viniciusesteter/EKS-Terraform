output "vpc_id" {
  value = aws_vpc.k8s_private_vpc.id
}

output "eks_subnet_ids" {
  value = aws_subnet.k8s-eks-subnet.*.id
}

output "cluster_name" {
  value = local.cluster_name
}