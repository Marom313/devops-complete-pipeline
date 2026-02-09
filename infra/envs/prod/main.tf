module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
}

module "ecr" {
  source        = "../../modules/ecr"
  project_name  = var.project_name
  repo_name     = var.ecr_repo_name
}

module "iam_jenkins" {
  source        = "../../modules/iam_jenkins"
  project_name  = var.project_name
  ecr_repo_arn  = module.ecr.repository_arn
}

module "alb" {
  source              = "../../modules/alb"
  project_name        = var.project_name
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  app_port            = var.app_port
}

module "jenkins_ec2" {
  source              = "../../modules/ec2"
  name                = "${var.project_name}-jenkins"
  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.public_subnet_ids[0]
  instance_type       = var.instance_type_jenkins
  key_name            = var.key_name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  extra_ingress_ports = [8080] # Jenkins UI
  iam_instance_profile_name = module.iam_jenkins.instance_profile_name
  user_data_path      = "${path.module}/userdata_jenkins.sh"
}

module "app_ec2" {
  source              = "../../modules/ec2"
  name                = "${var.project_name}-app"
  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.public_subnet_ids[1]
  instance_type       = var.instance_type_app
  key_name            = var.key_name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  extra_ingress_ports = [] # app not public directly
  iam_instance_profile_name = null
  user_data_path      = null
}

# Allow ALB -> App on app_port
resource "aws_security_group_rule" "alb_to_app" {
  type                     = "ingress"
  security_group_id        = module.app_ec2.sg_id
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = module.alb.alb_sg_id
}

# Register app instance to ALB Target Group
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.app_ec2.instance_id
  port             = var.app_port
}
