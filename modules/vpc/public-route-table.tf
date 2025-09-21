

resource "aws_route_table" "k8s-public-rt" {
    vpc_id      = aws_vpc.vpc-learning-k8s.id
    depends_on = [ aws_internet_gateway.k8s-public-igw ]
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.k8s-public-igw.id
    }
    tags = {
        Name = "public route table"
        description = "This is public route table"
    }   
}