terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }

  backend "s3" {
    bucket = "paulopkl-github-actions-tf"
    key    = "terraform.tfstate"
    region = "us-west-1"
    # dynamodb_table = "terraform-lock-table" # Optional: DynamoDB table for state locking
    encrypt = true # Enable state file encryption
  }
}

provider "aws" {
  # Configuration options
}

provider "null" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}
