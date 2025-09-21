# vpc modeule
module "vpc" {
  source = "./modules/vpc"
}



# ec2 module
module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids  
}