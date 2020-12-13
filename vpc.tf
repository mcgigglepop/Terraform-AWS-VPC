# AWS VPC Resource
resource "aws_vpc" "app_vpc" {
  cidr_block = "172.17.0.0/16"

  tags = {
    Environment     = var.environment
    Service         = var.service
  }
}