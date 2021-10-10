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
  azs = [
      "az1", 
      "az2",
      "az3"
  ]
  private_subnets = zipmap(data.aws_subnets.private.ids, local.azs)
}