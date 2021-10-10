# output "instance_ami" {
#   value = aws_instance.ubuntu.ami
# }

# output "instance_arn" {
#   value = aws_instance.ubuntu.arn
# }

output "vpc_cidr" {
  value = data.aws_vpc.default.cidr_block
}

output "private_subnets" {
  value = local.private_subnets
}