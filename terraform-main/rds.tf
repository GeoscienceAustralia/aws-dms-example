#==============================================================
# Database / rds.tf
#==============================================================

# Create a target RDS instance

resource "aws_db_instance" "target" {
  identifier              = "${var.stack_name}-${var.environment}-${var.identifier}-target"
  allocated_storage       = "${var.target_storage}"
  engine                  = "${var.target_engine}"
  engine_version          = "${var.target_engine_version}"
  instance_class          = "${var.target_instance_class}"
  name                    = "${var.target_db_name}"
  username                = "${var.target_username}"
  password                = "${var.target_password}"
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]
  multi_az                = "${var.target_rds_is_multi_az}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds-subnet.id}"
  backup_retention_period = "${var.target_backup_retention_period}"
  backup_window           = "${var.target_backup_window}"
  maintenance_window      = "${var.target_maintenance_window}"
  storage_encrypted       = "${var.target_storage_encrypted}"

  # Skip final snapshot for environments that don't start with 'p'
  # e.g. for environments that aren't 'prod'
  skip_final_snapshot = "${replace(replace(var.environment, "/^[^p].*/", "1"),"/^p.*$/", "0")}"

  tags {
    Name        = "${var.stack_name}_rds_target"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Create a source RDS instance (will be removed when on-premise database is being used)

resource "aws_db_instance" "source" {
  identifier              = "${var.stack_name}-${var.environment}-${var.identifier}-source"
  allocated_storage       = "${var.source_storage}"
  engine                  = "${var.source_engine}"
  engine_version          = "${var.source_engine_version}"
  instance_class          = "${var.source_instance_class}"
  name                    = "${var.source_db_name}"
  username                = "${var.source_username}"
  password                = "${var.source_password}"
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]
  multi_az                = "${var.source_rds_is_multi_az}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds-subnet.id}"
  backup_retention_period = "${var.source_backup_retention_period}"
  backup_window           = "${var.source_backup_window}"
  maintenance_window      = "${var.source_maintenance_window}"
  storage_encrypted       = "${var.source_storage_encrypted}"
  snapshot_identifier     = "${var.source_snapshot}"

  # only for dev/test builds
  skip_final_snapshot = true

  tags {
    Name        = "${var.stack_name}_rds_source"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Create a subnet group to house the RDS

resource "aws_db_subnet_group" "rds-subnet" {
  name        = "${var.stack_name}_${var.environment}_rds_subnet_group"
  description = "${var.stack_name} RDS Subnet Group"
  subnet_ids  = ["${aws_subnet.database.*.id}"]

  tags {
    Name        = "${var.stack_name}_${var.environment}_rds_subnet_group"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}
