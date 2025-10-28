variable "project_name" {}

variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "key_name" {}

variable "ami_id" {
  default = "ami-07860a2d7eb515d9a"
}

