# Route Tables for the Public Subnets
###########################################################

# Public Route Table A
resource "aws_route_table" "public_route_table_a" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Public Route Table B
resource "aws_route_table" "public_route_table_b" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Route Tables for the Private Subnets
###########################################################

# Private Route Table A
resource "aws_route_table" "private_route_table_a" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_a.id}"
  }

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Private Route Table B
resource "aws_route_table" "private_route_table_b" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_b.id}"
  }

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}
