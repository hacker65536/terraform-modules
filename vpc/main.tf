provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.dns_hostnames}"
  enable_dns_support   = "${var.dns_support}"

  tags {
    Name      = "${var.tag_env_name}"
    CostGroup = "${var.tag_cost_grp}"
    Author    = "${var.tag_author}"
  }
}

resource "aws_vpc_dhcp_options" "dns" {
  domain_name         = "${var.pri_domain_name} ${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name      = "${var.tag_env_name}"
    CostGroup = "${var.tag_cost_grp}"
    Author    = "${var.tag_author}"
  }
}

resource "aws_vpc_dhcp_options_association" "dns" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns.id}"
}

resource "aws_route53_zone" "dns" {
  name    = "${var.pri_domain_name}"
  comment = "${var.tag_env_name} local dns"
  vpc_id  = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "sub" {
  count      = "${var.subnets}"
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,count.index)}"

  tags {
    Name      = "${var.tag_env_name}"
    CostGroup = "${var.tag_cost_grp}"
    Author    = "${var.tag_author}"
  }
}
