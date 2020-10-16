resource "aws_security_group" "my_service_web_server_sg" {
  name        = "web_server"
  description = "Allow http and ssh"
  vpc_id      = aws_vpc.my_service.id
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

resource "aws_security_group_rule" "my_service_sg_in_icmp" {
  type        = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"

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
