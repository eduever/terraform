provider "aws" {
  region  = "us-east-1"
  profile = "nzbadmin"
}

terraform {
  required_version = ">= 0.12"
}


############## s3 bucket ########################

resource "aws_s3_bucket" "s3" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true
}

output "bucketname" {
  value = aws_s3_bucket.s3.*.id
}

variable "bucket_name" {
  default = "terraform-infra-automation04"
}


################# DynamoDB table for backend ####################
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-locking04"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
