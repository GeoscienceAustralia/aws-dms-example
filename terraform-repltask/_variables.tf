#==============================================================
# Database / outputs.tf
#==============================================================
#==============================================================
# variables.tf
#==============================================================

# This file is used to set variables that are passed to sub 
# modules to build our stack

#--------------------------------------------------------------
# Terraform Remote State
#--------------------------------------------------------------

# Define the remote objects that terraform will use to store
# state. We use a remote store, so that you can run destroy
# from a seperate machine to the one it was built on.

terraform {
  required_version = ">= 0.9.1"

  backend "s3" {
    # This is an s3bucket you will need to create in your aws 
    # space
    bucket = "tfstate-701941925126-db"

    # The key should be unique to each stack, because we want to
    # have multiple enviornments alongside each other we set
    # this dynamically in the bitbucket-pipelines.yml with the
    # --backend
    key = "dblink-repl"

    region = "ap-southeast-2"

    # This is a DynamoDB table with the Primary Key set to LockID
    lock_table = "terraform-lock-db"

    #Enable server side encryption on your terraform state
    encrypt = true
  }
}

#--------------------------------------------------------------
# Global Config
#--------------------------------------------------------------

# Variables used in the global config

provider "aws" {
  region = "ap-southeast-2"
}

variable "availability_zones" {
  description = "Geographically distanced areas inside the region"

  default = {
    "0" = "ap-southeast-2a"
    "1" = "ap-southeast-2b"
    "2" = "ap-southeast-2c"
  }
}

#--------------------------------------------------------------
# Meta Data
#--------------------------------------------------------------

# Used in tagginga and naming the resources

variable "stack_name" {
  description = "The name of our application"
  default     = "integration-dblink"
}

variable "owner" {
  description = "A group email address to be used in tags"
  default     = "autobots@ga.gov.au"
}

variable "environment" {
  description = "Used for seperating terraform backends and naming items"
  default     = "dev"
}

#--------------------------------------------------------------
# DMS Config
#--------------------------------------------------------------

#Variables used in the database config

variable "dms_source_arn" {
  description = "The ARN of the source database"
}

variable "dms_target_arn" {
  description = "The ARN of the target database"
}

variable "replication_instance_arn" {
  description = "The ARN of the replication instance"
}

variable "replication_task_id" {
  description = "Unique identifier for the task"
}
