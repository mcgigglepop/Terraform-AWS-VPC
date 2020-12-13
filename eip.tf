# EIP A
resource "aws_eip" "elastic_ip_a" {
  vpc        = true

  tags = {
    Environment     = var.environment
    Service         = var.service
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

# EIP B
resource "aws_eip" "elastic_ip_b" {
  vpc        = true

  tags = {
    Environment     = var.environment
    Service         = var.service
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}