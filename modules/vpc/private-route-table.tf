

resource "aws_route_table" "k8s-private-rt" {
    count       = length(var.private_subnet_cidrs)
    vpc_id      = aws_vpc.vpc-learning-k8s.id
    depends_on = [ aws_nat_gateway.k8s-nat-gateway ]
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.k8s-nat-gateway[count.index].id
    }
    tags = {
        Name = "private route table"
        description = "This is private route table"
    } 
}