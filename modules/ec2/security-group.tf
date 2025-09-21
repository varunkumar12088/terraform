
resource "aws_security_group" "learning_k8s_app_sg" {
  name        = "learning_k8s_app_sg"
  description = "Security group for app server with SSM and HTTPS"
  vpc_id      = var.vpc_id

  # Allow inbound HTTPS from anywhere (if public-facing)
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound (required for SSM to work)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

