variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "SSH Key name"
  default     = "github-deploy-key-pair" # Name of the SSH key pair
}
