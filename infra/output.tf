# Output the public IP of the EC2 instance
output "public_ip" {
  value = aws_instance.simple_http_server.public_ip
}
