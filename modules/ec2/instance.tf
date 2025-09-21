

resource "aws_instance" "ids" {
    count         = var.instance_count
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.private_subnet_ids[count.index % length(var.private_subnet_ids)]
    vpc_security_group_ids = [ aws_security_group.learning_k8s_app_sg.id ]
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name
    associate_public_ip_address = false
    user_data = file("${path.module}/bootstrap.sh")
    tags = {
        Name = "${var.instance_name}-${count.index + 1}"
    }
}


resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids   = var.private_subnet_ids
  security_group_ids = [aws_security_group.learning_k8s_app_sg.id]
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids   = var.private_subnet_ids
  security_group_ids = [aws_security_group.learning_k8s_app_sg.id]
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids   = var.private_subnet_ids
  security_group_ids = [aws_security_group.learning_k8s_app_sg.id]
}
