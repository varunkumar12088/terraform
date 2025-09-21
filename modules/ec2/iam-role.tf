
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