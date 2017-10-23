#==============================================================
# Database / rds-sg.tf
#==============================================================

# Security groups for the RDS.

resource "aws_security_group" "rds" {
  name        = "${var.stack_name}_${var.environment}_rds_sg"
  description = "Allow no inbound traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  # ingress {
  #   from_port       = "${var.db_port_num}"
  #   to_port         = "${var.db_port_num}"
  #   protocol        = "TCP"
  #   security_groups = ["${var.app_sg_id}"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name        = "${var.stack_name}-${var.environment}-rds-sg"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}
