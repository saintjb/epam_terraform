variable "ami_id" {
  description = "Value of AMI"
  default = "ami-0022f774911c1d690"
}

variable "inst_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "db_instance_class" {
  description = "DB engine type"
  default = "db.t2.micro"
}

variable "engine_type" {
  description = "Engine"
  default = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  default = "8.0.28"
}

variable "db_username" {
  description = "User for DB"
  default = "task"
}

variable "db_password" {
  description = "Password for DB"
  default = "nvb0Ert9"
}