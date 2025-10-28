variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {type = list(string)}
variable "azs" {type = list(string)}
variable "cluster_name" {}
variable "key_name" {}
variable "sns_email" {}
variable "region" {  default = "us-east-1"  }
