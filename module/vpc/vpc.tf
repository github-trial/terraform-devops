## Provisioning VPC
resource "aws_vpc" "main-vpc" {
  cidr_block       = "10.81.0.0/18"
  tags = {
    Name = "assign-test"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "${var.subnet-cidr}"
  availability_zone = "${var.avail_zone}"
  tags = {
    Name = "assign-test-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  tags = {
    Name = "assign-test-igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "assign-test-rt"
  }
}

##outputs for each resouces....
output "vpc_id" {
  value       = "${aws_vpc.main-vpc.id}"
}

output "gw_id" {
  value       = "${aws_internet_gateway.gw.id}"
}

output "rt_id" {
  value      = "${aws_route_table.rt.id}"
}

output "sub-id" {
  value      = "${aws_subnet.subnet.id}"
}

