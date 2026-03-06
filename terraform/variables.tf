variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "ecom-app"
  type        = string
  default     = "ecom-app"
}

variable "docker_image" {
  description = "Docker image for React E-Commerce"
  type        = string
  default     = "princepodwalverma1/ecom-app:latest"
}

variable "app_port" {
  description = "Port on which React app runs inside container"
  type        = number
  default     = 3001
}