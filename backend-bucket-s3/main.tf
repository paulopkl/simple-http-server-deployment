terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucketName

  force_destroy = true

  tags = {
    Name        = "Bucket for Github Actions stores tfstate backend"
    Environment = "test"
  }
}

output "name" {
  value = var.bucketName
}
