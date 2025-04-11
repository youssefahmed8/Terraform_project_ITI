vpc_cidr = "10.0.0.0/16"

public_subnets = {
  "us-east-1a" = "10.0.0.0/24",
  "us-east-1b" = "10.0.2.0/24"
}

private_subnets = {
  "us-east-1a" = "10.0.1.0/24",
  "us-east-1b" = "10.0.3.0/24"
}

instance_type = "t2.micro"
key_name      = "joeo"