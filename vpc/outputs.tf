output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "azs" {
  value = "${var.azs}"
}

output "public_subnets_id" {
  value = ["${aws_subnet.public.*.id}"]
}

output "aws_region" {
  value = "${var.region}"
}

output "aws_internet_gateway" {
  value = "${aws_internet_gateway.gw.id}"
}
