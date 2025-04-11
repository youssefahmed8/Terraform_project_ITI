variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = {
    "us-east-1a" = "10.0.0.0/24",
    "us-east-1b" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  default = {
    "us-east-1a" = "10.0.1.0/24",
    "us-east-1b" = "10.0.3.0/24"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "joeo"
}