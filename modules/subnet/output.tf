output "subnet_id" {
	value = "${aws_subnet.myapp-subnet.*.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.myapp-subnet.*.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.myapp-vpc.id}"

}
