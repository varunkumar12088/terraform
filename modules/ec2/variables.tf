variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
    default     = 3
}

variable "ami_id" {
    description = "The AMI ID for the EC2 instances"
    type        = string
    default     = "ami-0a362673a063d7c55"  
  
}

variable "instance_type" {
    description = "The instance type for the EC2 instances"
    type        = string
    default     = "t3.xlarge"
}

variable "instance_name" {
    description = "value for Name tag of the instance"
    type        = string
    default     = "Dev-Ec2-Learning"
}

variable "role_action" {
    description = "Action to allow"
    type        = string
    default     = "sts:AssumeRole"
}

variable "role_effect" {
    description = "Effect to allow"
    type        = string
    default     = "Allow"
  
}

variable "role_service" {
    description = "Service to assume the role"
    type        = string
    default     = "ec2.amazonaws.com"
}

variable "policy_arn" {
    description = "The ARN of the policy to attach"
    type        = string
    default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "private_subnet_ids" {
    description = "List of private subnet IDs"
    type        = list(string)
}
