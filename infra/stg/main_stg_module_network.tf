module "network" {
  source = "../modules/network"
  tags = {
    Env = basename(path.cwd)
  }
}