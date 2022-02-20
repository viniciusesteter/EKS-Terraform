module "worknodes" {
  source         = "../modules/worknodes"
  eks_subnet_ids = module.network.eks_subnet_ids
  cluster_name   = module.network.cluster_name

  worknodes = 1
  worknode_desired_size = 1
  worknode_max_size = 2
  worknode_min_size = 1

  tags = {
    Env = basename(path.cwd)
  }
}