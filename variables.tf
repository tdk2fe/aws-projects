variable "region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
}

locals {
  private_subnets = toset([ for id in data.aws_subnet_ids.private_subnets.ids : id ])
  

    private_subnet_1 = local.private_subnets[0]
}