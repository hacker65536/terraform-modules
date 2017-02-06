provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}

# want a better idea about tagging author
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}

# tagging default_route_table
resource "aws_default_route_table" "defrt" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}

resource "aws_route" "pub_igw_route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_vpc_dhcp_options" "dns" {
  domain_name         = "${var.pri_domain_name} ${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}

resource "aws_vpc_dhcp_options_association" "dns" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns.id}"
}

resource "aws_route53_zone" "dns" {
  name    = "${var.pri_domain_name}"
  comment = "${var.vpc_name} local dns"
  vpc_id  = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "sub" {
  count      = "${var.subnets}"
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,count.index)}"

  tags = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}
