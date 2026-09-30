variable "instance_ami_id" {
  type = string

}

variable "instance_type" {
  type = string

}

variable "subnet_id" {
  type = string



}
variable "environment" {
  type = string

}


# variable "instance_count" {
#   description = "this for the number of the ec2 instances"
#   default = 4
#   type = number
# }

variable "associate_public_ip_address" {
  type = bool
  default = true
}