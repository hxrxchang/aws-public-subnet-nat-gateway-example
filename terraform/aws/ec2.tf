data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "my_service" {
  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.auth.id
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.my_service_public_1a.id
  vpc_security_group_ids      = [aws_security_group.my_service_web_server_sg.id]

  tags = {
    Name = "my_service"
  }
}
