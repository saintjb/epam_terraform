output "vpc" {
  value = data.aws_vpc.vpc_default.id
  description = "Default VPC"
}

output "subnets" {
  value = data.aws_subnets.vpc_subnets.ids
  description = "Default Subnets"
}

output "security_groups" {
  value = data.aws_security_groups.vpc_sg.ids
  description = "Default Security Groups"
}