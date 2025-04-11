variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets with AZ as key"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnets with AZ as key"
  type        = map(string)
}