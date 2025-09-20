output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.vpc-learning-k8s.id   
}


output "public_subnet_ids" {
    description = "List of public subnet IDs"
    value       = aws_subnet.k8s-public-subnet[*].id
}

output "private_subnet_ids" {
    description = "List of private subnet IDs"
    value       = aws_subnet.k8s-private-subnet[*].id
}

output "nat_gateway_ids" {
    description = "List of NAT Gateway IDs"
    value       = aws_nat_gateway.k8s-nat-gateway[*].id
}

output "internet_gateway_id" {
    description = "The ID of the Internet Gateway"
    value       = aws_internet_gateway.k8s-public-igw.id
}

output "public_route_table_id" {
    description = "The ID of the Public Route Table"
    value       = aws_route_table.k8s-public-rt.id
}

output "private_route_table_ids" {
    description = "List of Private Route Table IDs"
    value       = aws_route_table.k8s-private-rt[*].id
  
}