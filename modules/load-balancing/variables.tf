variable "vpc_id" {
  description = "VPC ID for load balancer resources"
  type        = string
}

variable "public_subnet_ids" {
  description = "Map of public subnet IDs"
  type        = map(string)
}

variable "private_subnet_ids" {
  description = "Map of private subnet IDs"
  type        = map(string)
}

variable "security_group_id" {
  description = "Security group ID for load balancers"
  type        = string
}