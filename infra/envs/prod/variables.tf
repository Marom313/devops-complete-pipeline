variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "devops-home-task"
}

variable "key_name" {
  type        = string
  description = "EXISTING EC2 Key Pair name in us-east-1 (you create/download it from AWS Console once)"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Your public IP /32 recommended. Use 0.0.0.0/0 only if you must."
  default     = "0.0.0.0/0"
}

variable "instance_type_jenkins" {
  type    = string
  default = "t3.micro"
}

variable "instance_type_app" {
  type    = string
  default = "t3.micro"
}

variable "app_port" {
  type    = number
  default = 8000
}

variable "ecr_repo_name" {
  type    = string
  default = "devops-home-task-api"
}
