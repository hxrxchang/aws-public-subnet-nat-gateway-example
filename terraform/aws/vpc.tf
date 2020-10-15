# my_service
resource "aws_vpc" "my_service" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my service"
  }
}

resource "aws_subnet" "my_service_public_1a" {
  vpc_id = aws_vpc.my_service.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my_service_public_1a"
  }
}

# external_service
resource "aws_vpc" "external_service" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "external service"
  }
}

resource "aws_subnet" "external_service_public_1a" {
  vpc_id = aws_vpc.external_service.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "external_service_public_1a"
  }
}
