# AWS Key Pair for the EC2 Instance
resource "aws_key_pair" "generated_key" {
  key_name   = "MyKeyPairForEc2"
  public_key = var.ec2_key_name

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  } 
} 