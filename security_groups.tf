# ----------------------------------------------------------------------------------------------------------------------
# Security Groups - jump box
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "bastion-host-sg" {
    name = "${var.env.shortname}-bastion-host-sg"
    tags = {

        Name = upper("${var.env.shortname}-bastion-host-sg")
        Purpose = "BastionHost SG"
    }
    vpc_id = aws_vpc.vpc-1.id
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = var.management_addrs.default.cidr_block
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}


# ----------------------------------------------------------------------------------------------------------------------
# Security Groups - mongodb-pvtlink security group
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" mongodb-pvtlink {
    name = "${var.env.shortname}-mongodb-pvtlink-sg"
    tags = {
        Name = upper("${var.env.shortname}-mongodb-pvtlink-sg")
        Purpose = "Security Group"
    }
    vpc_id = aws_vpc.vpc-1.id
    ingress {
       from_port   = 0
       to_port     = 65535
       protocol    = "tcp"
       cidr_blocks = [
           aws_subnet.app-a.cidr_block,
           aws_subnet.app-b.cidr_block,
           aws_subnet.app-c.cidr_block,
           aws_subnet.backend-a.cidr_block,
           aws_subnet.backend-b.cidr_block,
           aws_subnet.backend-c.cidr_block
       ]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

# ----------------------------------------------------------------------------------------------------------------------
# Security Groups - ccscanner
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "ccscanner-sg" {
    name = "${var.env.shortname}-ccscanner-sg"
    tags = {
        Name = upper("${var.env.shortname}-ccscanner-sg")
        Purpose = "Security Group"
    }
    vpc_id = aws_vpc.vpc-1.id
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = [
            "${aws_instance.linux-bastion-a.private_ip}/32"
        ]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

# ----------------------------------------------------------------------------------------------------------------------
# Security Groups - mq security group
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "mq-sg" {
    name   = "${var.env.shortname}-mq-sg"
    vpc_id = aws_vpc.vpc-1.id
    tags = {
        Name = upper("${var.env.shortname}-mq-sg")
        Purpose = "Security Group"
    }

    ingress {
        from_port = 5671
        protocol = "tcp"
        to_port = 5671
        cidr_blocks = [
            aws_subnet.app-a.cidr_block,
            aws_subnet.app-b.cidr_block,
            aws_subnet.app-c.cidr_block,
            aws_subnet.backend-a.cidr_block,
            aws_subnet.backend-b.cidr_block,
            aws_subnet.backend-c.cidr_block,
        ]
    }

    ingress {
        from_port = 443
        protocol = "tcp"
        to_port = 443
        cidr_blocks = [
            aws_subnet.app-a.cidr_block,
            aws_subnet.app-b.cidr_block,
            aws_subnet.app-c.cidr_block,
            aws_subnet.backend-a.cidr_block,
            aws_subnet.backend-b.cidr_block,
            aws_subnet.backend-c.cidr_block,
        ]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# ----------------------------------------------------------------------------------------------------------------------
# Security Groups - elasticache security group
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "elasticache-sg" {
    name   = "${var.env.shortname}-elasticache-sg"
    vpc_id = aws_vpc.vpc-1.id
    tags = {
        Name = upper("${var.env.shortname}-elasticache-sg")
        Purpose = "Security Group"
    }

    ingress {
        from_port = 6379
        protocol = "tcp"
        to_port = 6379
        cidr_blocks = [
            aws_subnet.app-a.cidr_block,
            aws_subnet.app-b.cidr_block,
            aws_subnet.app-c.cidr_block,
            aws_subnet.backend-a.cidr_block,
            aws_subnet.backend-b.cidr_block,
            aws_subnet.backend-c.cidr_block,
        ]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}