variable "aws_region"{
    type = string
}
variable "environment" {
  type = string
}
variable "bucket_name" {
  type = string
}

variable "aws_s3_bucket_versioning" {
  type = string
}

variable "aws_s3_bucket_acl" {
  type = string
}