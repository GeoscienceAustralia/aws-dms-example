#==============================================================
# main.tf
#==============================================================

provider "aws" {
  region = "${var.region}"
}

#--------------------------------------------------------------
# Remote State Infrastructure
#--------------------------------------------------------------

# Create the remote objects that terraform will use to store
# state - an S3 bucket and a DynamoDB table.

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}-db"
  acl    = "private"

  tags {
    Name       = "terraform-state"
    owner      = "${var.owner}"
    stack_name = "${var.stack_name}"
    created_by = "space-provisioner"
  }
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "terraform-lock-db"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name       = "terraform-state-locking"
    owner      = "${var.owner}"
    stack_name = "${var.stack_name}"
    created_by = "space-provisioner"
  }
}
