provider "aws" {
  profile = "vlm"
  region  = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_count    = length(data.aws_availability_zones.available.names)
  subnet_type = ["public_front_net", "private_back_net", "private_db_net"]
  bits        = ceil(log(local.az_count * length(local.subnet_type), 2))

  subnets_cidr_blocks = {
    for i, name in local.subnet_type :
    "${name}" => [
      for subnet_num in range(i * local.az_count, (i + 1) * local.az_count) :
      cidrsubnet(var.cidr_block, local.bits, subnet_num)
    ]
  }
}

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "vlm-vpc"
#   cidr = var.cidr_block

#   azs              = data.aws_availability_zones.available.names
#   private_subnets  = local.subnets_cidr_blocks.private_back_net
#   public_subnets   = local.subnets_cidr_blocks.public_front_net

#   create_igw         = true
#   enable_nat_gateway = true
#   single_nat_gateway = true

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }

# module "d-vpc" {
#   source = "../../modules/aws-network"
#   env    = "development"
# }

resource "aws_instance" "jenkins-instance" {
  ami             = "ami-09cd747c78a9add63"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  # vpc_id          = module.vpc.vpc_id
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]

  user_data = "${file("install_docker.sh")}"


  associate_public_ip_address = true
  
  tags = {
    Name = "Jenkins-Instance"
  }
}

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "jenkins_ip_address" {
  value = "${aws_instance.jenkins-instance.public_dns}"
}