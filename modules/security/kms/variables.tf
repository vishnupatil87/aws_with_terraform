#################################################
# ENVIRONMENT
#################################################

variable "environment" {

  type = string
}

#################################################
# KMS
#################################################

variable "key_alias" {

  type = string
}

variable "description" {

  type = string
}

variable "enable_key_rotation" {

  type = bool

  default = true
}

variable "deletion_window_in_days" {

  type = number

  default = 30
}

#################################################
# TAGS
#################################################

variable "common_tags" {

  type = map(string)
}