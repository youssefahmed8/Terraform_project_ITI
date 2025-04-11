output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}

output "public_instance_ips" {
  description = "Public IP addresses of the public instances"
  value = {
    "Apachepub1" = module.compute.apache_pub1_ip
    "Apachepub2" = module.compute.apache_pub2_ip
  }
}

output "private_instance_ips" {
  description = "Private IP addresses of the private instances"
  value = {
    "Apachepriv1" = module.compute.apache_priv1_ip
    "Apachepriv2" = module.compute.apache_priv2_ip
  }
}

output "public_load_balancer_dns" {
  description = "DNS name of the public load balancer"
  value       = module.load_balancing.public_lb_dns
}

output "private_load_balancer_dns" {
  description = "DNS name of the private load balancer"
  value       = module.load_balancing.private_lb_dns
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = module.security.security_group_id
}