# Make sure to update the values to their intended value
# params:
# key: This will be the path of your Terraform state file
# bucket: The Amazon S3 bucket that the Terraform state file will be deployed to and referenced.
# region: The region of the S3 bucket
# dynamdb_table: The name of a DynamoDB table to use for state locking and consistency. The table must have a primary key named LockID. If not present, locking will be disabled.

terraform {
    backend "s3" {
<<<<<<< HEAD:config-rules-terraform/administrator_account/backend.tf
        key            = ".terraform/terraformstate.tfstate"
        bucket         = "config-layer0"
        region         = "us-east-1"
        dynamodb_table = "config-terraform"
=======
        key            = "terraform.tfstate"
        bucket         = "config-layer0"
        region         = "us-east-1"
        dynamodb_table = "config-terraform"
>>>>>>> 5cd8889a595d99bb7d0bd21bf2ab920c68b3cc4a:multi-region-org-config-rules-terraform-master/secondary_account/backend.tf
    }
}
