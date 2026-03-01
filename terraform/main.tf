# terraform/main.tf

resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("${path.module}/../keySSH_ProjetFilRouge.pub")
}

resource "aws_instance" "devops_ec2" {
  ami                    = "ami-09d0c9a85bf1b9ea7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = aws_key_pair.devops_key.key_name

  user_data = file("user_data.sh")

  tags = {
    Name = "devops-ec2"
  }
}