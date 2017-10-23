#==============================================================
# variables.tf
#==============================================================

# This file is used to set variables that are passed to sub 
# modules to build our stack

#--------------------------------------------------------------
# Global Config
#--------------------------------------------------------------

# Variables used in the global config

variable "region" {
  description = "The AWS region we want to build this stack in"
  default     = "ap-southeast-2"
}

variable "stack_name" {
  description = "The name of our application"
  default     = "dblink"
}

variable "owner" {
  description = "A group email address to be used in tags"
  default     = "autobots@ga.gov.au"
}
