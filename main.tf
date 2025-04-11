module "networking" {
  source          = "./modules/networking"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "load_balancing" {
  source              = "./modules/load-balancing"
  vpc_id              = module.networking.vpc_id
  public_subnet_ids   = module.networking.public_subnet_ids
  private_subnet_ids  = module.networking.private_subnet_ids
  security_group_id   = module.security.security_group_id
}

module "compute" {
  source              = "./modules/compute"
  ami_id             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type      = var.instance_type
  key_name           = var.key_name
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  security_group_id  = module.security.security_group_id
  public_lb_arn      = module.load_balancing.public_lb_target_group_arn
  private_lb_arn     = module.load_balancing.private_lb_target_group_arn
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}