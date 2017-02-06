variable "profile" {
  description = "AWS_PROFILE"
  default     = "default"
}

variable "region" {
  description = "default region"
  default     = "us-west-2"
}

variable "cidr" {
  description = "vpc cidr_block"
  default     = "10.2.0.0/16"
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

variable "subnets" {
  default = 8
}

variable "pri_domain_name" {
  default = "project.local"
}

variable "vpc_name" {
  default = "vp_cname"
}

variable "tags" {
  default = {}
}
