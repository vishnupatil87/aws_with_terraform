variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "ec2-scheduler"
}


variable "ami_id" {
  type = string 
  default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
  type = string 
  default = "t3.micro"
}

variable "key_name" {
  sensitive = true
  type = string
  default = "patil-key-pair"
}



variable "instance_name" {
  default = "ec2_start_stop"
}

variable "environment" {
  default = "dev"
  
}