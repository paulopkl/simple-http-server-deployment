resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key locally to a file
resource "local_file" "private_key" {
  filename = "C:\\Users\\Paulo\\.ssh\\${var.key_name}.pem" # Path to save private key
  content  = tls_private_key.generated.private_key_pem
}

# Create an SSH Key Pair in AWS
resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = tls_private_key.generated.public_key_openssh
}

locals {
  key_name = aws_key_pair.generated.key_name
}
