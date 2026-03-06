output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.react_app_server.public_ip
}

output "app_url" {
  description = "React App URL"
  value       = "http://${aws_instance.react_app_server.public_ip}:${var.app_port}"
}