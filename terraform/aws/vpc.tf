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

resource "aws_subnet" "my_service_public_1a_for_nat" {
  vpc_id = aws_vpc.my_service.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my_service_public_1a_for_nat"
  }
}

resource "aws_internet_gateway" "my_service" {
  vpc_id = aws_vpc.my_service.id

  tags = {
    Name = "my_service"
  }
}

resource "aws_eip" "my_service_1a" {
  vpc = true
  tags = {
    Name = "my_service_1a"
  }
}

resource "aws_nat_gateway" "my_service_nat_1a" {
  subnet_id     = aws_subnet.my_service_public_1a_for_nat.id
  allocation_id = aws_eip.my_service_1a.id

  tags = {
    Name = "my_service_nat_1a"
  }
}

resource "aws_route_table" "my_service_public" {
  vpc_id = aws_vpc.my_service.id

  tags = {
    Name = "my_service_public"
  }
}

resource "aws_route_table" "my_service_nat" {
  vpc_id = aws_vpc.my_service.id

  tags = {
    Name = "my_service_nat"
  }
}

resource "aws_route" "my_service_public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.my_service_public.id
  gateway_id             = aws_internet_gateway.my_service.id
}

resource "aws_route" "my_service_to_external" {
  destination_cidr_block = "${aws_instance.external_service.public_ip}/32"
  route_table_id         = aws_route_table.my_service_public.id
  nat_gateway_id         = aws_nat_gateway.my_service_nat_1a.id
}

resource "aws_route" "my_service_nat" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.my_service_nat.id
  gateway_id             = aws_internet_gateway.my_service.id
}

resource "aws_route_table_association" "my_service_public_1a" {
  subnet_id      = aws_subnet.my_service_public_1a.id
  route_table_id = aws_route_table.my_service_public.id
}

resource "aws_route_table_association" "my_service_public_1a_for_nat" {
  subnet_id      = aws_subnet.my_service_public_1a_for_nat.id
  route_table_id = aws_route_table.my_service_nat.id
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

resource "aws_internet_gateway" "external_service" {
  vpc_id = aws_vpc.external_service.id

  tags = {
    Name = "external_service"
  }
}

resource "aws_route_table" "external_service_public" {
  vpc_id = aws_vpc.external_service.id

  tags = {
    Name = "external_service_public"
  }
}

resource "aws_route" "external_service_public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.external_service_public.id
  gateway_id             = aws_internet_gateway.external_service.id
}

resource "aws_route_table_association" "external_service_public_1a" {
  subnet_id      = aws_subnet.external_service_public_1a.id
  route_table_id = aws_route_table.external_service_public.id
}
