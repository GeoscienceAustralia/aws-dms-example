#==============================================================
# Database / dms-repl-task.tf
#==============================================================

# Create a new DMS replication task
resource "aws_dms_replication_task" "dblink" {
  migration_type = "full-load"

  #replication_instance_arn = "${aws_dms_replication_instance.link.replication_instance_arn}"
  replication_instance_arn = "${var.replication_instance_arn}"
  replication_task_id      = "${var.replication_task_id}"
  source_endpoint_arn      = "${var.dms_source_arn}"
  table_mappings           = "${data.template_file.table_mappings.rendered}"
  target_endpoint_arn      = "${var.dms_target_arn}"

  tags {
    Name        = "${var.stack_name}-dms-${var.environment}-replication-task"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Reference the DMS table mappings
data "template_file" "table_mappings" {
  template = "${file("table_mappings.tpl")}"
}
