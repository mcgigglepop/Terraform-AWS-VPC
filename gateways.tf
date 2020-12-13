# Internet Gateway for the Public Subnet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# NAT Gateway A
resource "aws_nat_gateway" "nat_gateway_a" {
  subnet_id     = "${aws_subnet.public_subnet_a.id}"
  allocation_id = "${aws_eip.elastic_ip_a.id}"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# NAT Gateway B
resource "aws_nat_gateway" "nat_gateway_b" {
  subnet_id     = "${aws_subnet.public_subnet_b.id}"
  allocation_id = "${aws_eip.elastic_ip_b.id}"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}