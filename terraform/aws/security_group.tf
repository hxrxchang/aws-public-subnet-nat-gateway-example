# my_service
resource "aws_security_group" "my_service_web_server_sg" {
  name        = "web_server"
  description = "Allow http and ssh"
  vpc_id      = aws_vpc.my_service.id
  tags = {
    Name = "my_service_web_server_sg"
  }
}

resource "aws_security_group_rule" "my_service_sg_in_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.my_service_web_server_sg.id
}

resource "aws_security_group_rule" "my_service_sg_in_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.my_service_web_server_sg.id
}

resource "aws_security_group_rule" "my_service_sg_out_all" {
  type        = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 0
  to_port     = 0
  protocol    = "-1"

  security_group_id = aws_security_group.my_service_web_server_sg.id
}

# external_service
resource "aws_security_group" "external_service_web_server_sg" {
  name        = "web_server"
  description = "Allow http from my service and ssh"
  vpc_id      = aws_vpc.external_service.id
  tags = {
    Name = "external_service_web_server_sg"
  }
}

resource "aws_security_group_rule" "external_service_sg_in_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // my_serviceのサブネットのNAT GatewayのEIPからのみ許可
  cidr_blocks = [
    "${aws_eip.my_service_1a.public_ip}/32"
    # "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.external_service_web_server_sg.id
}

resource "aws_security_group_rule" "external_service_sg_in_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  # sshはローカルからもできるように許可しちゃう
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.external_service_web_server_sg.id
}

resource "aws_security_group_rule" "external_service_sg_out_all" {
  type        = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 0
  to_port     = 0
  protocol    = "-1"

  security_group_id = aws_security_group.external_service_web_server_sg.id
}
