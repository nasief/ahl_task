# Main file, entry point
# We can have everything here but better to separate for more readability
module "vpc" {
  source           = "../modules/vpc"
  region           = var.region
  project_name     = var.project_name
  vpc_cidr         = var.vpc_cidr
  pub_sub_cidr     = var.pub_sub_cidr
  pri_sub_db_cidr  = var.pri_sub_db_cidr
  pri_sub_app_cidr = var.pri_sub_app_cidr
}

module "nat" {
  source         = "../modules/nat"
  pub_sub_id     = module.vpc.pub_sub_id
  igw_id         = module.vpc.igw_id
  vpc_id         = module.vpc.vpc_id
  pri_sub_app_id = module.vpc.pri_sub_app_id
  pri_sub_db_id  = module.vpc.pri_sub_db_id
}

module "security-group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source         = "../modules/rds"
  db_sg_id       = module.security-group.db_sg_id
  pri_sub_app_id = module.vpc.pri_sub_db_id
  pri_sub_db_id  = module.vpc.pri_sub_app_id
  db_username    = var.db_username
  db_password    = var.db_password
}

module "ec2" {
  source         = "../modules/ec2"
  project_name   = module.vpc.project_name
  client_sg_id   = module.security-group.client_sg_id
  pri_sub_db_id  = module.vpc.pri_sub_db_id
  pri_sub_app_id = module.vpc.pri_sub_app_id
}
