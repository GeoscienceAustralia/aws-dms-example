# DMS Example

## Creates an example AWS DMS for replicating an (on-prem) Oracle database to a cloud-based Postgres database.

### terraform-main
This will create:

 * VPC with a VPN gateway
 * Source and target RDS instances
 * DMS Endpoints for each RDS instance
 * DMS Replication instance

This is designed to be deployed once.

### terraform-repltask
This will create:

 * DMS Replication Task

This is designed to be deployed multiple times.

## Set Variables

Set the following variables in variables.tf:

 *Terraform Remote State*
 * bucket - an s3 bucket that exists in your aws space (see Preperation)
 * lock_table - a dynamodb table in your aws space with the primary key LockID (see Preperation)
 
*Replication main*

Set the following environment variables (substituting the details of your application)

* `export TF_VAR_source_snapshot=<snapshot to restore source database from>`
* `export TF_VAR_source_db_name=<source database name>`
* `export TF_VAR_source_password=<source admin user password>`
* `export TF_VAR_source_username=<source admin user password>`
* `export TF_VAR_source_app_username=<source application user password>`
* `export TF_VAR_source_app_password=<source application user password>`
* `export TF_VAR_target_db_name=<target database name>`
* `export TF_VAR_target_password=<admin user password>`
* `export TF_VAR_target_username=<admin user account name>`

*Replication task*

Edit `_variables.tf`. Update `key = "dblink-repl"` within the s3 backend definition to another value, for example `key = "dblink-appname"`.

Set the following environment variables (substituting the details of your application)
 
 * `export TF_VAR_stack_name=<a unique name for this stack - e.g. dblink-appname>`
 * `export TF_VAR_dms_source_arn=<source endpoint ARN>`
 * `export TF_VAR_dms_target_arn=<target endpoint ARN>`
 * `export TF_VAR_replication_instance_arn=<replication instance ARN>`
 * `export TF_VAR_replication_task_id=<a unique name for this replication task>`

## Creating your infrastructure

1. `terraform init`
2. `terraform plan`
3. `terraform apply`

This command will output your database endpoint, which you will need below.

## Destroying your infrastructure

1. If you have run the infrastructure overnight you will have backups in your backup bucket. You will need to remove these so the terraform can destroy the bucket.
1. `terraform destroy`

This is assuming that you ran `terraform init` previously on the same machine
This command will tear down everything that terraform created.

## VPC Peering

Follow the [VPC Peering guide](https://docs.aws.amazon.com/AmazonVPC/latest/PeeringGuide/vpc-peering-basics.html):

1. Ensure your requester and accepter VPCs do not have overlapping IP address spaces.
1. The owner of the requester VPC sends a request to the owner of the accepter VPC to create the VPC peering connection. 
1. The owner of the accepter VPC accepts the VPC peering connection request to activate the VPC peering connection.
1. Add a route to each VPC's route tables that points to the IP address range of the other VPC.
1. Update security groups to allow traffic from either VPC.
1. Modify your VPC connection to enable DNS hostname resolution.
