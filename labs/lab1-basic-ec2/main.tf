provider "aws" {
  region = var.region
}

   # Hyderabad region

resource "aws_instance" "ec2" {
  ami           = "ami-090b9c8aa1c84aefc"
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.sg_name]
  subnet_id     = var.subnet_id   # <-- explicitly set subnet

  tags = {
    Name    = "lab1-basic-ec2"
    Project = var.project
  }
}

