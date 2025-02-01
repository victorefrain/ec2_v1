provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  # No necesita vpc_cidr, public_subnet_cidr y private_subnet_cidr
}

module "bastion" {
  source = "./modules/bastion"
  instance_type = var.bastion_instance_type
  ami = var.ami
  subnet_id = module.network.public_subnet_id
  security_group_id = module.security.bastion_sg_id
}

module "mongodb" {
  source = "./modules/mongodb"
  instance_type = var.mongodb_instance_type
  ami = var.ami
  subnet_id = module.network.private_subnet_id
  security_group_id = module.security.mongodb_sg_id
}

module "webserver" {
  source = "./modules/webserver"
  instance_type = var.webserver_instance_type
  ami = var.ami
  subnet_id = module.network.private_subnet_id
  security_group_id = module.security.webserver_sg_id
}
