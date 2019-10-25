########RESSOURCES########

provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             = "${length(split(",",var.azs))}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, var.subnet_bits, count.index + 1)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
 
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "rtpb" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "routepb" {
  route_table_id         = "${aws_route_table.rtpb.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_route_table_association" "rtappb" {
  count          = "${length(split(",",var.azs))}"
  subnet_id      = "${element(aws_subnet.public.*.id,count.index)}"
  route_table_id = "${aws_route_table.rtpb.id}"
}

