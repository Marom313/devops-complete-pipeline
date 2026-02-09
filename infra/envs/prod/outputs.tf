output "jenkins_public_ip" {
  value = module.jenkins_ec2.public_ip
}

output "app_public_ip" {
  value = module.app_ec2.public_ip
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}
