# ----------------------------------------------------------------------------------------------------------------------
# NAT Gateway a
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "eip-a" {
    tags = {
        Name = upper("NATGW-EIP-A")
        Purpose = "EIP"
    }
}

resource "aws_nat_gateway" "natgw-a" {
    tags = {
        Name = upper("NATGW-A")
        Purpose = "NATGW"
    }
    allocation_id = aws_eip.eip-a.id
    subnet_id = aws_subnet.public-a.id
}

# ----------------------------------------------------------------------------------------------------------------------
# NAT Gateway b
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "eip-b" {
    tags = {

        Name = upper("NATGW-EIP-B")
        Purpose = "EIP"
    }
}

resource "aws_nat_gateway" "natgw-b" {
    tags = {

        Name = upper("NATGW-B")
        Purpose = "NATGW"
    }
    allocation_id = aws_eip.eip-b.id
    subnet_id = aws_subnet.public-b.id
}

# ----------------------------------------------------------------------------------------------------------------------
# NAT Gateway c
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "eip-c" {
    tags = {

        Name = upper("NATGW-EIP-C")
        Purpose = "EIP"
    }
}

resource "aws_nat_gateway" "natgw-c" {
    tags = {

        Name = upper("NATGW-C")
        Purpose = "NATGW"
    }
    allocation_id = aws_eip.eip-c.id
    subnet_id = aws_subnet.public-c.id
}

# ----------------------------------------------------------------------------------------------------------------------
# Internet Gateway
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
    tags = {

        Name = upper("IGW")
        Purpose = "IGW"
    }
    vpc_id = aws_vpc.vpc-1.id
}