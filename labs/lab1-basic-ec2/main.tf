provider "aws" {
  region = var.region
}

# Pull shared infra outputs
data "terraform_remote_state" "shared" {
  backend = "local"
  config = {
    path = "../../shared-infra/terraform.tfstate"
  }
}

# EC2 instance in shared subnet
resource "aws_instance" "lab1_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.shared.outputs.subnet_id

  tags = {
    Name  = "lab1-basic-ec2"
    owner = "wesley"
    tera  = "lab1"
    purpose = "compute"
    env     = "lab"

  }
}