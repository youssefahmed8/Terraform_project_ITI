output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = { for k, subnet in aws_subnet.public : k => subnet.id }
}

output "private_subnet_ids" {
  value = { for k, subnet in aws_subnet.private : k => subnet.id }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}