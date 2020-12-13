# EC2 Launch Config
resource "aws_launch_configuration" "app" {
  name_prefix          = format("%s-%s-", var.service, var.environment)
  image_id             = var.ec2_ami[data.aws_region.current.name]
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name
  key_name             = aws_key_pair.generated_key.key_name

  security_groups = [
    aws_security_group.ec2_instance_security_group.id
  ]

  associate_public_ip_address = true
  enable_monitoring           = true
  placement_tenancy           = "default"
  user_data                   = data.template_cloudinit_config.cloud-init.rendered

  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = var.ec2_root_volume_type
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    data.template_file.shell-script,
    data.template_cloudinit_config.cloud-init
  ] 
}