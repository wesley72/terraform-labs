provider "aws" {
      
                region = var.aws_region

}

# VPC
resource "aws_vpc" "shared_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "tera-shared-vpc"
    owner   = "wesley"
    tera    = "shared"
    purpose = "networking"
    env     = "lab"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "shared_igw" {
  vpc_id = aws_vpc.shared_vpc.id

  tags = {
    Name    = "tera-shared-igw"
    owner   = "wesley"
    tera    = "shared"
    purpose = "gateway"
    env     = "lab"
  }
}

# Public Subnet
resource "aws_subnet" "shared_subnet_public" {
  vpc_id                  = aws_vpc.shared_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = "ap-south-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "tera-shared-subnet-public"
    owner   = "wesley"
    tera    = "shared"
    purpose = "public-networking"
    env     = "lab"
  }
}

# Private Subnet
resource "aws_subnet" "shared_subnet_private" {
  vpc_id            = aws_vpc.shared_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = "ap-south-2b"

  tags = {
    Name    = "tera-shared-subnet-private"
    owner   = "wesley"
    tera    = "shared"
    purpose = "private-networking"
    env     = "lab"
  }
}

# Public Route Table
resource "aws_route_table" "shared_public_rt" {
  vpc_id = aws_vpc.shared_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shared_igw.id
  }

  tags = {
    Name    = "tera-shared-public-rt"
    owner   = "wesley"
    tera    = "shared"
    purpose = "routing-public"
    env     = "lab"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.shared_subnet_public.id
  route_table_id = aws_route_table.shared_public_rt.id
}

# Private Route Table (no IGW route)
resource "aws_route_table" "shared_private_rt" {
  vpc_id = aws_vpc.shared_vpc.id

  tags = {
    Name    = "tera-shared-private-rt"
    owner   = "wesley"
    tera    = "shared"
    purpose = "routing-private"
    env     = "lab"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.shared_subnet_private.id
  route_table_id = aws_route_table.shared_private_rt.id
}