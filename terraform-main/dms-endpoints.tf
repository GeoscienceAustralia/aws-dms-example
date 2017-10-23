#==============================================================
# dms-endpoints.tf
#==============================================================

# Create an endpoint for the source database

resource "aws_dms_endpoint" "source" {
  database_name = "${var.source_db_name}"
  endpoint_id   = "${var.stack_name}-dms-${var.environment}-source"
  endpoint_type = "source"
  engine_name   = "${var.source_engine_name}"
  password      = "${var.source_app_password}"
  port          = "${var.source_db_port}"
  server_name   = "${aws_db_instance.source.address}"
  ssl_mode      = "none"
  username      = "${var.source_app_username}"

  tags {
    Name        = "${var.stack_name}-dms-${var.environment}-source"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Create an endpoint for the target database

resource "aws_dms_endpoint" "target" {
  database_name = "${var.target_db_name}"
  endpoint_id   = "${var.stack_name}-dms-${var.environment}-target"
  endpoint_type = "target"
  engine_name   = "${var.target_engine}"
  password      = "${var.target_password}"
  port          = "${var.target_db_port}"
  server_name   = "${aws_db_instance.target.address}"
  ssl_mode      = "none"
  username      = "${var.target_username}"

  tags {
    Name        = "${var.stack_name}-dms-${var.environment}-target"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}
