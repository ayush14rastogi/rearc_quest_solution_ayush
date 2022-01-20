data "aws_availability_zones" "available" {}

resource "aws_vpc" "myapp-vpc" {
  cidr_block       =  var.vpc_cidr_block
#  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}


resource "aws_subnet" "myapp-subnet" {
  count = 2
  vpc_id     = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block[count.index]
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "${var.env_prefix}-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "a-rtb-subnet" {
  count         = 2
  subnet_id     = "${aws_subnet.myapp-subnet.*.id[count.index]}"
#  subnet_id      = aws_subnet.myapp-subnet[count.index].id
  route_table_id = aws_route_table.myapp-rtb.id
}


resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  
  tags = {
    Name = "${var.env_prefix}-igw"
  } 
} 


resource "aws_route_table" "myapp-rtb" {
  vpc_id     = aws_vpc.myapp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }

  tags = {
    Name = "${var.env_prefix}-rtb"
  }
}


