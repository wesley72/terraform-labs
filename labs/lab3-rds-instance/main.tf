terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# -----------------------------
# 1. RDS Subnet Group
# -----------------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wesley-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "wesley-rds-subnet-group"
  }
}

# -----------------------------
# 2. Security Group for RDS
# -----------------------------
resource "aws_security_group" "rds_sg" {
  name        = "wesley-rds-sg"
  description = "Allow DB access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "Postgres from EC2"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wesley-rds-sg"
  }
}

# -----------------------------
# 3. RDS Instance
# -----------------------------
resource "aws_db_instance" "wesley_rds" {
  identifier              = "wesley-lab3-db"
  engine                  = "postgres"
  engine_version          = "15.15"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp3"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = 7

  tags = {
    Name = "wesley-lab3-rds"
  }
}