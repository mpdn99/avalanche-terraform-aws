resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = format("%s-vpc", var.project)
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = format("%s-internet-gateway", var.project)
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = var.availability_zone
    map_public_ip_on_launch = false

    tags = {
        Name = format("%s-public-subnet", var.project)
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/ 0 "
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = format("%s-public-route-table", var.project)
    }
}

resource "aws_route_table_association" "public_route_table_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "public_security_group" {
    name = format("%s-public-security-group", var.project)
    description = "Allow inbound traffic from the internet"
    vpc_id = aws_vpc.vpc.id
    depends_on = [
      aws_vpc.vpc
    ]

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    tags = {
        Name = format("%s-public-security-group", var.project)
    }
}