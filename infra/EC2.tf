locals {
  key_name = var.key_name
}

# Get the latest Ubuntu 24.04 AMI ID
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID for Ubuntu images

  filter {
    name   = "name"
    values = ["ubuntu-*-20.04-*"]
    # You can add more filters like:
    # root-device-type = "ebs"
    # architecture = "x86_64"
  }
}

# Create EC2 Instance using the SSH key
resource "aws_instance" "simple_http_server" {
  ami             = data.aws_ami.ubuntu_24_04.id
  instance_type   = var.instance_type
  key_name        = local.key_name # aws_key_pair.generated.key_name
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.allow_ssh.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y rsync
  EOF

  tags = {
    Environment = "test"
    Name        = "simple_http_server for Github Deploy"
  }
}
