#==============================================================
# Database / outputs.tf
#==============================================================

# Create a subnet in each availability zone.

resource "aws_subnet" "database" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block        = "${element(var.database_subnet_cidr, count.index)}"
  availability_zone = "${lookup(var.availability_zones, count.index)}"

  tags {
    Name        = "${var.stack_name}-database-subnet-${var.environment}-${lookup(var.availability_zones, count.index)}"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}
