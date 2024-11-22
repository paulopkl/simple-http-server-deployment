# Create an Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-gateway"
  }
}
