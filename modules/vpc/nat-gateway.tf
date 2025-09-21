

resource "aws_eip" "k8s-nat-eip" {
    count = length(var.private_subnet_cidrs)
    tags = {
        Name = "EIP: EIP for NAT Gateway"
    }   
}

resource "aws_nat_gateway" "k8s-nat-gateway" {
    count          = length(var.private_subnet_cidrs)
    depends_on     = [ aws_eip.k8s-nat-eip ]
    allocation_id  = aws_eip.k8s-nat-eip[count.index].id
    subnet_id      = aws_subnet.k8s-public-subnet[count.index].id
    tags = {
        Name = "Private NAT-Gateway"
        description = "This is NAT Gateway for private subnet"
    }   
}
