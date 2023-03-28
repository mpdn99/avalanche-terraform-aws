output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "public_security_group_id" {
    value = aws_security_group.public_security_group.id
}

output "public_route_table_id" {
    value = aws_route_table.public_route_table.id
}