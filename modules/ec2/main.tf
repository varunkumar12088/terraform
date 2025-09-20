resource "aws_security_group" "learning_k8s_app_sg" {
  name        = "learning_k8s_app_sg"
  description = "Security group for app server with SSM and HTTPS"
  vpc_id      = module.vpc.vpc_id

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

resource "aws_iam_role" "ec2-ssm-role" {
    name = "ec2-ssm-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = var.role_action
            Effect = var.role_effect
            Principal = {
                Service = var.role_service
            }
        }
        ]
    })  
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
    role       = aws_iam_role.ec2-ssm-role.name
    policy_arn = var.policy_arn
  
}

resource "aws_iam_instance_profile" "ec2_ssm" {
    name = "ec2-ssm-instance-profile"
    role = aws_iam_role.ec2-ssm-role.name
  
}

resource "aws_instance" "ids" {
    count         = var.instance_count
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.private_subnet_ids[count.index % length(module.vpc.private_subnet_ids)]
    vpc_security_group_ids = [ aws_security_group.learning_k8s_app_sg.id ]
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name
    associate_public_ip_address = false
    tags = {
        Name = var.instance_name + "-${count.index + 1}"
    }
}