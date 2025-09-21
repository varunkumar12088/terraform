
resource "aws_route_table_association" "public-rt-assoc" {
    count          = length(var.public_subnet_cidrs)
    depends_on     = [ aws_subnet.k8s-public-subnet, aws_route_table.k8s-public-rt ]
    subnet_id      = aws_subnet.k8s-public-subnet[count.index].id
    route_table_id = aws_route_table.k8s-public-rt.id  
}

resource "aws_route_table_association" "private-rt-assoc" {
    count          = length(var.private_subnet_cidrs)
    depends_on     = [ aws_subnet.k8s-private-subnet, aws_route_table.k8s-private-rt ]
    subnet_id      = aws_subnet.k8s-private-subnet[count.index].id
    route_table_id = aws_route_table.k8s-private-rt[count.index].id  
}