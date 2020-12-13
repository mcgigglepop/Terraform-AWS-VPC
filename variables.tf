# service level variables
variable "service" {
    description = "Application service name"
}
variable "environment" {
    description = "Application deployment environment"
}

# Autoscaling Variables
variable "asg_desired_capacity" {
  description = "The number of instances that should be running in the group"
  type        = string

  default = 2
}
variable "asg_health_check_grace_period" {
  description = "Time in seconds after instance comes into service before checking health"
  type        = string

  default = 300 # Terraform default is 300
}
variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
  type        = string

  default = 3
}
variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
  type        = string

  default = 1
} 
variable "description" {
  description = "Resource description tag"
  type        = string

  default = "Sample VPC Architecture"
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)

  default = {}
}

# EC2 Specific Variables
variable "ec2_ami" {
  description = "Map of Ubuntu Minimal AMIs by region"
  type        = map(string)

  default = {
    us-east-1    = "ami-7029320f"
    us-east-2    = ""
    us-west-1    = ""
    us-west-2    = ""
    eu-central-1 = ""
    eu-west-1    = ""
  }
}
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string

  default = "t2.micro"
}
variable "ec2_key_name" {
  description = "EC2 SSH Key"
  type        = string
}
variable "ec2_root_volume_size" {
  description = "Size of the root volume (in Gigabytes)"
  type        = string

  default = 8
}
variable "ec2_root_volume_type" {
  description = "Type of the root volume (standard, gp2, or io)"
  type        = string

  default = "gp2"
}