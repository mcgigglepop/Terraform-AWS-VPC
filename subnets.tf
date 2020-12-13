# Defined Private Subnets
############################################

# Private Subnet A
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "172.17.1.0/24"
  availability_zone = "us-east-1e"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Private Subnet B
resource "aws_subnet" "private_subnet_b" {
  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "172.17.2.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Defined Public Subnets
##########################################

# Public Subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "172.17.3.0/24"
  availability_zone = "us-east-1e"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}

# Public Subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "172.17.4.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}