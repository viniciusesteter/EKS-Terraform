module "cluster" {
  source         = "../modules/cluster"
  vpc_id         = module.network.vpc_id
  eks_subnet_ids = module.network.eks_subnet_ids
  cluster_name   = module.network.cluster_name

  tags = {
    Env = basename(path.cwd)
  }
}