# ----------------------------------------------------------------------------------------------------------------------
# VPC-1
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc-1" {
    cidr_block = "10.1.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {

        Name = upper("VPC-1")
        Purpose = "VPC"
    }
}

# ----------------------------------------------------------------------------------------------------------------------
# Subnets VPC-1
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "public-a" {
    tags = {
        Name = upper("PUBLIC-A-SUBNET")
        Purpose = "PUBLIC-A Subnet"
    }
    cidr_block = "10.1.0.0/24"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = true
    availability_zone = var.aws-az.us-east-1a
}
resource "aws_subnet" "public-b" {
    tags = {
        Name = upper("PUBLIC-B-SUBNET")
        Purpose = "PUBLIC-B Subnet"
    }
    cidr_block = "10.1.1.0/24"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = true
    availability_zone = var.aws-az.us-east-1b
}
resource "aws_subnet" "public-c" {
    tags = {
        Name = upper("PUBLIC-C-SUBNET")
        Purpose = "PUBLIC-C Subnet"
    }
    cidr_block = "10.1.3.0/24"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = true
    availability_zone = var.aws-az.us-east-1c
}
resource "aws_subnet" "app-a" {
    tags = {
        Name = upper("APP-A-SUBNET")
        Purpose = "APP-A Subnet"
    }
    cidr_block = "10.1.10.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1a
}
resource "aws_subnet" "app-b" {
    tags = {
        Name = upper("APP-B-SUBNET")
        Purpose = "APP-B Subnet"
    }
    cidr_block = "10.1.12.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1b
}
resource "aws_subnet" "app-c" {
    tags = {
        Name = upper("APP-C-SUBNET")
        Purpose = "APP-C Subnet"
    }
    cidr_block = "10.1.14.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1c
}
resource "aws_subnet" "backend-a" {
    tags = {
        Name = upper("BACKEND-A-SUBNET")
        Purpose = "BACKEND-A Subnet"
    }
    cidr_block = "10.1.16.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1a
}
resource "aws_subnet" "backend-b" {
    tags = {
        Name = upper("BACKEND-B-SUBNET")
        Purpose = "BACKEND-B Subnet"
    }
    cidr_block = "10.1.18.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1b
}
resource "aws_subnet" "backend-c" {
    tags = {
        Name = upper("BACKEND-C-SUBNET")
        Purpose = "BACKEND-C Subnet"
    }
    cidr_block = "10.1.20.0/23"
    vpc_id = aws_vpc.vpc-1.id
    map_public_ip_on_launch = false
    availability_zone = var.aws-az.us-east-1c
}

# ----------------------------------------------------------------------------------------------------------------------
# Public route
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "public-route-table" {
    tags = {

        Name = upper("PUBLIC-ROUTE")
        Purpose = "PUBLIC ROUTE"
    }
    vpc_id = aws_vpc.vpc-1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public-route-table-association-a" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id = aws_subnet.public-a.id
}

resource "aws_route_table_association" "public-route-table-association-b" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id = aws_subnet.public-b.id
}

resource "aws_route_table_association" "public-route-table-association-c" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id = aws_subnet.public-c.id
}


# ----------------------------------------------------------------------------------------------------------------------
# Private route a
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "private-route-table-a" {
    tags = {

        Name = upper("PRIVATE-ROUTE-TABLE-A")
        Purpose = "PRIVATE ROUTE TABLE"
    }
    vpc_id = aws_vpc.vpc-1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw-a.id
    }
}

resource "aws_route_table_association" "private-route-table-app-a-association" {
    route_table_id = aws_route_table.private-route-table-a.id
    subnet_id = aws_subnet.app-a.id
}

resource "aws_route_table_association" "private-route-table-backend-a-association" {
    route_table_id = aws_route_table.private-route-table-a.id
    subnet_id = aws_subnet.backend-a.id
}

# ----------------------------------------------------------------------------------------------------------------------
# Private route a
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "private-route-table-b" {
    tags = {

        Name = upper("PRIVATE-ROUTE-TABLE-B")
        Purpose = "PRIVATE ROUTE TABLE"
    }
    vpc_id = aws_vpc.vpc-1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw-b.id
    }
}

resource "aws_route_table_association" "private-route-table-app-b-association" {
    route_table_id = aws_route_table.private-route-table-b.id
    subnet_id = aws_subnet.app-b.id
}

resource "aws_route_table_association" "private-route-table-backend-b-association" {
    route_table_id = aws_route_table.private-route-table-b.id
    subnet_id = aws_subnet.backend-b.id
}

# ----------------------------------------------------------------------------------------------------------------------
# Private route c
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "private-route-table-c" {
    tags = {

        Name = upper("PRIVATE-ROUTE-TABLE-C")
        Purpose = "PRIVATE ROUTE TABLE"
    }
    vpc_id = aws_vpc.vpc-1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw-c.id
    }
}

resource "aws_route_table_association" "private-route-table-app-c-association" {
    route_table_id = aws_route_table.private-route-table-c.id
    subnet_id = aws_subnet.app-c.id
}

resource "aws_route_table_association" "private-route-table-backend-c-association" {
    route_table_id = aws_route_table.private-route-table-c.id
    subnet_id = aws_subnet.backend-c.id
}
