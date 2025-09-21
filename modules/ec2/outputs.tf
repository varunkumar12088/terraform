output "aws_security_group_id" {
    description = "The ID of the security group"
    value       = aws_security_group.learning_k8s_app_sg.id
}

output "aws_iam_role_name" {
    description = "The name of the IAM role"
    value       = aws_iam_role.ec2_ssm_role.name
}

output "ssm_attached_policy" {
    description = "The attached policy ARN"
    value       = aws_iam_role_policy_attachment.ssm_attach.policy_arn
}

output "ec2_ssm_instance_profile_name" {
    description = "The name of the IAM instance profile"
    value       = aws_iam_instance_profile.ec2_ssm.name
}

output "aws_instance_ids" {
    description = "List of EC2 instance IDs"
    value       = aws_instance.ids[*].id
}