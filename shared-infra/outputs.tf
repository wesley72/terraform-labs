output "vpc_id" {
  value = aws_vpc.shared_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.shared_subnet_public.id
}

output "private_subnet_id" {
  value = aws_subnet.shared_subnet_private.id
}