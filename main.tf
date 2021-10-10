provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Class = "TestEnv"
      owner = "Tim"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Environment"
    values = ["TimsLab-Alpha"]
  }
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "tag:Network"
    values = ["Private"]
  }
}

resource "aws_instance" "default" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = data.aws_subnet_ids.private_subnets.0.id
  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_security_group" "tims-sg" {
  name        = "Tims SG"
  description = "SG for tim to use"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tims-sg.id
}
