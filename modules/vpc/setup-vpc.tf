

resource "aws_vpc" "vpc-learning-k8s" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "VPC: vpc-learning-k8s"
    }
}




