variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "db_username" {
  type    = string
  default = "wesleyadmin"
}

variable "db_password" {
  type      = string
  sensitive = true
}