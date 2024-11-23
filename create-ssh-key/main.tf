terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
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
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}

provider "tls" {
  # Configuration options
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key locally to a file
resource "local_file" "private_key" {
  ### LINUX ### replace to filename = "~/.ssh/${var.key_name}.pem"
  filename = "C:\\Users\\${var.windows-linux-username}\\.ssh\\${var.key_name}.pem" # Path to save private key
  content  = tls_private_key.generated.private_key_pem
}

# Create an SSH Key Pair in AWS
resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = tls_private_key.generated.public_key_openssh
}

output "ssh_key_location" {
  value = local_file.private_key.filename
}

output "instructions" {
  value = "Copy the content of that SSH Key and put in your Github repository"
}
