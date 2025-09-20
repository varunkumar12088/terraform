resource "aws_vpc" "vpc-learning-k8s" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "VPC: vpc-learning-k8s"
    }
}

resource "aws_subnet" "k8s-public-subnet" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.vpc-learning-k8s.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = element(var.ap-vailability_zones, count.index)
    tags = {
        Name = "Public-Subnet: Public Subnet ${count.index + 1}"
    }
}

resource "aws_subnet" "k8s-private-subnet" {
    count               = length(var.private_subnet_cidrs)
    vpc_id              = aws_vpc.vpc-learning-k8s.id
    cidr_block          = var.private_subnet_cidrs[count.index]
    availability_zone   = element(var.ap-vailability_zones, count.index)
    tags = {
        Name = "Private-Subnet: Private Subnet ${count.index + 1}"
    }
}

resource "aws_internet_gateway" "k8s-public-igw" {
    vpc_id = aws_vpc.vpc-learning-k8s.id
    tags = {
        Name = "Internet-Gateway: IGW for VPC"
    }   
}

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
    subnet_id      = aws_subnet.k8s-private-subnet[count.index].id
    tags = {
        Name = "Private NAT-Gateway: NAT Gateway for Private Subnets"
    }   
}

resource "aws_route_table" "k8s-public-rt" {
    vpc_id      = aws_vpc.vpc-learning-k8s.id
    depends_on = [ aws_internet_gateway.k8s-public-igw ]
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.k8s-public-igw.id
    }
    tags = {
        Name = "Public-Route-Table: RT for Public Subnets"
    }   
}

resource "aws_route_table" "k8s-private-rt" {
    count       = length(var.private_subnet_cidrs)
    vpc_id      = aws_vpc.vpc-learning-k8s.id
    depends_on = [ aws_nat_gateway.k8s-nat-gateway ]
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.k8s-nat-gateway[0].id
    }
}