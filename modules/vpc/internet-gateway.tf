
resource "aws_internet_gateway" "k8s-public-igw" {
    vpc_id = aws_vpc.vpc-learning-k8s.id
    tags = {
        Name = "Internet-Gateway: IGW for VPC"
    }   
}