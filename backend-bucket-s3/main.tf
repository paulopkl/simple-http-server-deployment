terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
}

locals {
  bucketName = "paulopkl-github-actions-tf"
}

resource "aws_s3_bucket" "example" {
  bucket = local.bucketName

  force_destroy = true

  tags = {
    Name        = "Bucket for Github Actions stores tfstate backend"
    Environment = "test"
  }
}

output "name" {
  value = local.bucketName
}
