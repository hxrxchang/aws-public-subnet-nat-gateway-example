resource "aws_vpc" "my-service" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my service"
  }
}

resource "aws_vpc" "external-service" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "external service"
  }
}
