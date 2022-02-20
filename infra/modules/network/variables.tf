locals {
  cluster_name = "k8s-cluster-${var.tags["Env"]}"
}
variable "tags" { }