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