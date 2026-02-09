module "frontend" {
  source = "./modules/ec2"

  name = "frontend"
}

module "backend" {
  source = "./modules/ec2"

  name = "backend"
}

module "database" {
  source = "./modules/ec2"

  name = "database"
}

resource "aws_vpc" "FHS_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "FHS-VPC"
  }
}