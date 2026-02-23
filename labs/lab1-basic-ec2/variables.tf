variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-2"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-090b9c8aa1c84aefc" # Amazon Linux 2 (example)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}