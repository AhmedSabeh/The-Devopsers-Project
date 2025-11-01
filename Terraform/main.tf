module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs                 = var.azs
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = "1.29"
  subnet_ids        = module.vpc.public_subnet_ids
  instance_types    = ["t3.medium"]
  desired_size      = 2
  min_size          = 1
  max_size          = 2
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  region      = var.region
  cluster_name = var.cluster_name
  node_group_name   = module.eks.node_group_name
  sns_email = var.sns_email
  depends_on = [ module.eks ]
}
