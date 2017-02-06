variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-west-2"
}

variable "cidr" {
  default = "10.2.0.0/16"
}

variable "author" {
  default = "auhtor"
}

variable "dns_support" {
  default = true
}

variable "dns_hostnames" {
  default = true
}

variable "subnets" {
  default = 8
}

variable "pri_domain_name" {
  default = "project.local"
}

variable "tag_author" {
  default = "build-user"
}

variable "tag_env_name" {
  default = "terraform-env"
}

variable "tag_cost_grp" {
  default = "tag_cost_grp"
}
