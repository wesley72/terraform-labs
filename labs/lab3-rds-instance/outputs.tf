output "rds_endpoint" {
  value = aws_db_instance.wesley_rds.address
}

output "rds_port" {
  value = aws_db_instance.wesley_rds.port
}