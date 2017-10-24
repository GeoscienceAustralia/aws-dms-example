#==============================================================
# Database / dms-repl-instance.tf
#==============================================================

# Create a new DMS replication instance
resource "aws_dms_replication_instance" "link" {
  allocated_storage            = "${var.replication_instance_storage}"
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "${lookup(var.availability_zones, count.index)}"
  engine_version               = "${var.replication_instance_version}"
  multi_az                     = false
  preferred_maintenance_window = "${var.replication_instance_maintenance_window}"
  publicly_accessible          = false
  replication_instance_class   = "${var.replication_instance_class}"
  replication_instance_id      = "dms-replication-instance-tf"
  replication_subnet_group_id  = "${aws_dms_replication_subnet_group.dms.id}"
  vpc_security_group_ids       = ["${aws_security_group.rds.id}"]

  tags {
    Name        = "${var.stack_name}-dms-${var.environment}-${lookup(var.availability_zones, count.index)}"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Create a subnet group using existing VPC subnets
resource "aws_dms_replication_subnet_group" "dms" {
  replication_subnet_group_description = "DMS replication subnet group"
  replication_subnet_group_id          = "dms-replication-subnet-group-tf"
  subnet_ids                           = ["${aws_subnet.database.*.id}"]
}
