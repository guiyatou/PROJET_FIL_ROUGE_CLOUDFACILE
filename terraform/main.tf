# terraform/main.tf

resource "aws_instance" "devops_ec2" {
  ami                    = "ami-09d0c9a85bf1b9ea7"  
  instance_type          = "t3.micro"               
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "devops-ec2"
  }
}