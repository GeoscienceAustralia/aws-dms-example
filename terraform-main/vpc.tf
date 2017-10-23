#==============================================================
# Shared / vpc.tf
#==============================================================

# Create the Virtual Private Cloud that the rest of our 
# infratructure will be built in.

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.stack_name}-${var.environment}-vpc"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.stack_name}-${var.environment}-vpn"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}

# Internet gateway - remove for network isolation
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.stack_name}-${var.environment}-vpc"
    owner       = "${var.owner}"
    stack_name  = "${var.stack_name}"
    environment = "${var.environment}"
    created_by  = "terraform"
  }
}
