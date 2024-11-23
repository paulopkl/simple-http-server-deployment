variable "key_name" {
  type        = string
  description = "SSH Key name"
  default     = "github-deploy-key-pair"
}

variable "windows-linux-username" {
  type        = string
  description = "Put exact the name of your current user, root is not recommended"
  default     = "Paulo"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
