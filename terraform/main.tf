provider "aws" {
  region = var.region
}

# Security group
resource "aws_security_group" "react_sg" {
  name        = "react-app-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 3001
  to_port     = 3001
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]   # Internet se access ke liye
}

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "react_app_server" {
  ami           = "ami-0ba8d27d35e9915fb" # Ubuntu 22.04 LTS
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = [aws_security_group.react_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo docker run -d -p 3001:3001 princepodwalverma/react-ecommerce:latest
              EOF

  tags = {
    Name = "ReactEcomServer"
  }
}