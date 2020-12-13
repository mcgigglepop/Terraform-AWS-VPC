# Unhealthy Host Count Cloudwatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "unhealthy-host-count" {

  alarm_name          = format("%s-%s-lb-unhealthy-host", var.service, var.environment)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Minimum"
  threshold           = 0

  actions_enabled   = "true"
  alarm_description = "Unhealthy host count is greater than 0 for external lb"

  dimensions = {
    "TargetGroup"  = element(split(":", "${aws_lb_target_group.external-tg.arn}"), 5)
    "LoadBalancer" = "${aws_lb.external_lb.arn_suffix}"
  }
}