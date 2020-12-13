# RDS Database Instance 
resource "aws_db_instance" "rds_instance" {
  identifier = "${format("%s-%s-rds-instance", var.service, var.environment)}"

  name              = var.rds_database_name
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_storage_size
  engine            = "postgres"
  storage_type      = "gp2"

  backup_retention_period = var.db_backup_retention_period
  db_subnet_group_name    = "${aws_db_subnet_group.private_subnets_group.id}"
  multi_az                = var.db_multi_az
  parameter_group_name    = "${format("%s-%s-parameter-group", var.service, var.environment)}"


  username = var.rds_user
  password = var.rds_password

  vpc_security_group_ids = ["${aws_security_group.postgresql_security_group.id}"]

  skip_final_snapshot       = "${var.db_final_snapshot_identifier == "" ? true : false}"
  final_snapshot_identifier = "${var.db_final_snapshot_identifier == "" ? null : var.db_final_snapshot_identifier}"

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  }

  depends_on = [aws_db_parameter_group.rds_parameter_group]
}

# Parameter Group for Managing the RDS Instance
resource "aws_db_parameter_group" "rds_parameter_group" {
  count = "${var.db_instance_count > 0 ? 1 : 0}"

  name        = "${format("%s-%s-parameter-group", var.service, var.environment)}"
  family      = var.db_family
  description = var.description

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  }
}

# Subnet Group for the Private Subnets
resource "aws_db_subnet_group" "private_subnets_group" {
  name       = "${var.environment}-${var.service}-private-subnets"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  tags = {
    "Environment"     = var.environment
    "Service"         = var.service
  }
}