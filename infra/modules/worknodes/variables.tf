locals {
  node_name = "k8s-node-${var.tags["Env"]}"
}

variable "eks_subnet_ids" { }
variable "cluster_name" { }
variable "tags" { }
variable "worknodes" { }
variable "worknode_desired_size" { }
variable "worknode_max_size" { }
variable "worknode_min_size" { }
variable "node_group_name" { 
  type = string
  default = "k8s"
}