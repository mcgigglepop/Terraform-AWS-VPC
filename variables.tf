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

# Load Balancer Variables
variable "enable_deletion_protection" {
    description = "Boolean to enable delete protection on the ALB"
    type        = string

    default = false # Terraform default is false
}
variable "health_check_healthy_threshold" {
    description = "Number of consecutives checks before an unhealthy target is considered healthy"
    type        = string

    default = 5 # Terraform default is 5
}
variable "idle_timeout" {
    description = "Seconds a connection can idle before being disconnected"
    type        = string

    default = 60 # Terraform default is 60
}
variable "health_check_interval" {
    description = "Seconds between health checks"
    type        = string

    default = 5 # Terraform default is 30
}
variable "health_check_timeout" {
    description = "Seconds waited before a health check fails"
    type        = string

    default = 3 # Terraform default is 5
}
variable "health_check_unhealthy_threshold" {
    description = "Number of consecutive checks before considering a target unhealthy"
    type        = string

    default = 2 # Terraform default is 2
}

# RDS Specific Variables
variable "rds_database_name" {
  description = "Name of RDS Database"
}
variable "db_engine_version" {
  description = "RDS Database Engine Version"
  default     = "11.4"
}
variable "db_instance_class" {
  description = "Database Instance Class"
  default     = "db.t2.micro"
}
variable "db_storage_size" {
  description = "Database Storage Size"
  default     = "100"
}
variable "db_backup_retention_period" {
  description = "Database Backup Retention Period"
  default     = "7"
}
variable "db_multi_az" {
  description = "Databse Multi-AZ"
  default     = false
}
variable "rds_user" {
  description = "Name of the RDS Root User for the RDS"
}
variable "rds_password" {
  description = "Name of the RDS Root Password for the RDS"
}
variable "db_final_snapshot_identifier" {
  description = "RDS Final Snapshot Identifier"
  default     = ""
}
variable "db_instance_count" {
  description = "Database Instance Count"
  default     = 1
}
variable "db_family" {
  description = "Database Family"
  default     = "postgres11"
}
variable "description" {
  description = "Description for the Parameter Group"
  default     = "AWS APP VPC"
}