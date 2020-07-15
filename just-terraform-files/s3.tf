terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"
}

variable "bucket_name" {}

resource "aws_s3_bucket" "s3" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true
}

output "bucketname" {
  value = aws_s3_bucket.s3.*.id
}

