######VARIABLES#########

variable "azs" {
  default = "eu-west-1a"
}

variable region {
  default = "eu-west-1"
}

variable application {
  default = "lab"
}

variable environment {
  default = "d2si"
}

variable owner {
  default = "me"
}

variable "cidr_block" {
  default = "172.23.0.0/16"
}

variable "subnet_cidr" {
  default = "172.23.1.0/24"
}



########RESSOURCES########

provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet_cidr}"
  availability_zone       = "${var.azs}"
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
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.rtpb.id}"
}