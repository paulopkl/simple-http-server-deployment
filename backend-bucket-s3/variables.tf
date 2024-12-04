variable "bucketName" {
  type        = string
  description = "Bucket S3 name"
  default     = "paulopkl-github-actions-tf"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-1"
}
