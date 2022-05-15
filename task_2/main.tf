terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami = var.ami_id
  instance_type = var.inst_type
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = <<EOF
   #!/bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo systemctl start nginx
  EOF

  tags = {
      Name = "Nginx-instance"
  }

}

resource "aws_security_group" "nginx_sg" {
    name = "allow_http_https"
    description = "Allow nginx traffic"
    ingress   {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 80
      protocol = "tcp"
      to_port = 80
    } 

    egress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    } 
    tags = {
        Name = "nginx-sg"
    }
  
}

resource "aws_db_instance" "task_db" {
  allocated_storage = 20
  engine = var.engine_type
  engine_version = var.engine_version
  instance_class = var.db_instance_class
  name = "task_db"
  username = var.db_username
  password = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible = true
  
  tags = {
    Name = "AWS RDS by Terraform"
  }
}
 
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rds-sg"
  }
}