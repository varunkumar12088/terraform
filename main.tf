# vpc modeule
module "vpc" {
  source = "./modules/vpc"
}

# ec2 module

module "ec2" {
  source = "./modules/ec2"
  
}