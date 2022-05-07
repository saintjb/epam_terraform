terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "vpc_default" {
  default = true
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.vpc_default.id]
  }
}

data "aws_security_groups" "vpc_sg" {
  filter {
    name   = "group-name"
    values = ["*"]
  }
}
