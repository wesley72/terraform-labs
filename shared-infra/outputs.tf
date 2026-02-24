output "vpc_id" {
  value = aws_vpc.shared_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.shared_subnet_public.id
  #value = data.terraform_remote_state.shared.outputs.public_subnet_id

}

output "private_subnet_id" {
  value = aws_subnet.shared_subnet_private.id
}