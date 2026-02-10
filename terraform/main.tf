module "vpc" {
  source = "./modules/vpc"
}

module "frontend" {
  source = "./modules/ec2"

  name          = "hs_frontend"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.frontend_sg_id
}

module "backend" {
  source = "./modules/ec2"

  name          = "hs_backend"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet_id
  sg_id         = module.vpc.backend_sg_id
}

module "database" {
  source        = "./modules/ec2"
  name          = "hs_database"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet_id
  sg_id         = module.vpc.db_sg_id
}
