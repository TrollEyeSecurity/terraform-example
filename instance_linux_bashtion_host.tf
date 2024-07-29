# ----------------------------------------------------------------------------------------------------------------------
# aws_instance.linux-bastion-a
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "linux-bastion-a" {
    ami                          = data.aws_ami.ubuntu-2204.id
    disable_api_termination      = true
    availability_zone            = var.aws-az.us-east-1a
    subnet_id                    = aws_subnet.public-a.id
    instance_type                = var.instance_type.default.jump-box
    key_name                     = "${var.env.shortname}-us-east-1"
    monitoring                   = true
    tags                         = {
        "Name"    = upper("Linux-Bastion-Host-A")
        "Purpose" = "jump box"
    }
    tenancy                      = var.tenancy.default
    volume_tags                  = {
        "Name" = upper("Linux-Bastion-A-ROOT-EBS")
    }
    vpc_security_group_ids       = [
        aws_security_group.bastion-host-sg.id
    ]

    credit_specification {
        cpu_credits = "standard"
    }

    root_block_device {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 40
        volume_type           = "gp3"
    }
    timeouts {}
}

resource "aws_eip" "linux-bastion-host-a" {
    instance = aws_instance.linux-bastion-a.id
    domain   = "vpc"
    tags = {
        Name    = upper("Linux-Bastion-Host-A-EIP")
        Purpose = "EIP"
    }
}
