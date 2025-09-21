

resource "aws_subnet" "k8s-public-subnet" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.vpc-learning-k8s.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = element(var.ap-vailability_zones, count.index)
    tags = {
        Name = "Public-Subnet: Public Subnet ${count.index + 1}"
    }
}