# External App Load Balancer
resource "aws_lb" "external_lb" {

  name     = format("%s-%s-external-lb", var.service, var.environment)
  internal = false
  subnets  = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  security_groups = [aws_security_group.external-lb.id]

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout

  tags = merge(
    {
      "Name"            = format("%s-%s-external-lb", var.service, var.environment),
      "Environment"     = var.environment
      "Service"         = var.service
    },
    var.tags
  )
}

# external Load Balancer Target Group 
resource "aws_lb_target_group" "external-tg" {

  name     = format("%s-%s-external-tg", var.service, var.environment)
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app_vpc.id

  health_check {
    healthy_threshold   = var.health_check_healthy_threshold
    interval            = var.health_check_interval
    path                = "/index.php"
    port                = 80
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = "302"
  }

  tags = merge(
    {
      "Name"        = format("%s-%s-external-tg", var.service, var.environment),
      "Environment"     = var.environment
      "Service"         = var.service
    },
    var.tags
  )
}

# listener port 80
resource "aws_lb_listener" "external-80" {

  load_balancer_arn = aws_lb.external_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
	target_group_arn = aws_lb_target_group.external-tg.arn
	type             = "forward"
  }
}