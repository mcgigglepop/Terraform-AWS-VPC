# external load balancer security group
resource "aws_security_group" "external-lb" {
  description = "External Load Balancer SG"
  name        = format("%s-%s-external-lb", var.service, var.environment)
  vpc_id      = aws_vpc.app_vpc.id

  tags = merge(
    {
      "Name"        = format("%s-%s-external-lb-sg", var.service, var.environment),
      "Environment"     = var.environment
      "Service"         = var.service
    },
    var.tags
  )
}

# egress all
resource "aws_security_group_rule" "external-lb-egress" {
  security_group_id = aws_security_group.external-lb.id

  type        = "egress"
  protocol    = "-1"
  from_port   = 0
  to_port     = 0
  cidr_blocks = ["0.0.0.0/0"]

}

# 80 all
resource "aws_security_group_rule" "ingress-external-lb-80" {
  security_group_id = aws_security_group.external-lb.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]

}

# AWS Security Group for the EC2 Instances
resource "aws_security_group" "ec2_instance_security_group" {
  description = "EC2 instance security group"
  name        = format("%s-%s-ec2-security-group", var.service, var.environment)
  vpc_id      = aws_vpc.app_vpc.id

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  }
}

# ec2 egress all
resource "aws_security_group_rule" "ec2-egress" {
  security_group_id = aws_security_group.ec2_instance_security_group.id

  type        = "egress"
  protocol    = "-1"
  from_port   = 0
  to_port     = 0
  cidr_blocks = ["0.0.0.0/0"]

}

# RDS Ingress
resource "aws_security_group_rule" "redis-ingress-ec2" {
  security_group_id = aws_security_group.postgresql_security_group.id

  type      = "ingress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  source_security_group_id = aws_security_group.ec2_instance_security_group.id
}

# ec2 ingress for 80 external lb
resource "aws_security_group_rule" "ec2-ingress-external-lb" {
  security_group_id = aws_security_group.ec2_instance_security_group.id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  source_security_group_id = aws_security_group.external-lb.id
}

# security group for the elb health check
resource "aws_security_group_rule" "ec2-ingress-external-lb-health-check" {
  security_group_id = aws_security_group.ec2_instance_security_group.id

  type      = "ingress"
  from_port = 8000
  to_port   = 8000
  protocol  = "tcp"

  source_security_group_id = aws_security_group.external-lb.id
}

# Security Group for the Postgres
resource "aws_security_group" "postgresql_security_group" {
  description = "RDS instance Security Group"
  name        = "${format("%s-%s-postgresql-sg", var.service, var.environment)}"
  vpc_id      = aws_vpc.app_vpc.id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  }
}