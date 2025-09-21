

resource "aws_subnet" "k8s-private-subnet" {
    count               = length(var.private_subnet_cidrs)
    vpc_id              = aws_vpc.vpc-learning-k8s.id
    cidr_block          = var.private_subnet_cidrs[count.index]
    availability_zone   = element(var.ap-vailability_zones, count.index)
    tags = {
        Name = "Private-Subnet: Private Subnet ${count.index + 1}"
    }
}