variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
  type        = string
}
variable "key_name" {
  description = "Name of the SSH key pair to use for EC2"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group for EC2"
  type        = string
}

variable "project" {
  description = "Project tag for resources"
  type        = string
  default     = "terraform-labs"
}