

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