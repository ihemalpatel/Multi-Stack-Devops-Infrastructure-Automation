module "vpc" {
  source = "./modules/vpc"
}

module "frontend" {
  source = "./modules/ec2"

  name              = "frontend"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  sg_id = module.vpc.frontend_sg_id
}

module "backend" {
  source = "./modules/ec2"

  name              = "backend"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.private_subnet_id
  sg_id = module.vpc.backend_sg_id
}

