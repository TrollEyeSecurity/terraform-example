# ----------------------------------------------------------------------------------------------------------------------
# aws_instance.ccscanner-1
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "ccscanner-1" {
    ami                          = data.aws_ami.ccscanner.id
    disable_api_termination      = true
    availability_zone            = var.aws-az.us-east-1a
    subnet_id                    = aws_subnet.backend-a.id
    instance_type                = var.instance_type.default.ccscanner
    key_name                     = "${var.env.shortname}-security-management"
    tags                         = {
        "Name"    = upper("CCScanner-1")
        "Purpose" = "scanner"
    }
    tenancy                      = var.tenancy.default
    volume_tags                  = {
        "Name" = upper("CCScanner-1-ROOT-EBS")

    }
    vpc_security_group_ids       = [
        aws_security_group.ccscanner-sg.id
    ]

    credit_specification {
        cpu_credits = "standard"
    }

    root_block_device {
        delete_on_termination = false
        encrypted             = true
        kms_key_id            = aws_kms_key.default-data-key.arn
        volume_size           = 80
        volume_type           = "gp3"
    }
    timeouts {}
}

# ----------------------------------------------------------------------------------------------------------------------
# aws_instance.ccscanner-2
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "ccscanner-2" {
    ami                          = data.aws_ami.ccscanner.id
    disable_api_termination      = true
    availability_zone            = var.aws-az.us-east-1b
    subnet_id                    = aws_subnet.backend-b.id
    instance_type                = var.instance_type.default.ccscanner
    key_name                     = "${var.env.shortname}-security-management"
    tags                         = {
        "Name"    = upper("CCScanner-2")
        "Purpose" = "scanner"
    }
    tenancy                      = var.tenancy.default
    volume_tags                  = {
        "Name" = upper("CCScanner-2-ROOT-EBS")

    }
    vpc_security_group_ids       = [
        aws_security_group.ccscanner-sg.id
    ]

    credit_specification {
        cpu_credits = "standard"
    }

    root_block_device {
        delete_on_termination = false
        encrypted             = true
        kms_key_id            = aws_kms_key.default-data-key.arn
        volume_size           = 80
        volume_type           = "gp3"
    }
    timeouts {}
}

# ----------------------------------------------------------------------------------------------------------------------
# aws_instance.ccscanner-3
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "ccscanner-3" {
    ami                          = data.aws_ami.ccscanner.id
    disable_api_termination      = true
    availability_zone            = var.aws-az.us-east-1c
    subnet_id                    = aws_subnet.backend-c.id
    instance_type                = var.instance_type.default.ccscanner
    key_name                     = "${var.env.shortname}-security-management"
    tags                         = {
        "Name"    = upper("CCScanner-3")
        "Purpose" = "scanner"
    }
    tenancy                      = var.tenancy.default
    volume_tags                  = {
        "Name" = upper("CCScanner-3-ROOT-EBS")

    }
    vpc_security_group_ids       = [
        aws_security_group.ccscanner-sg.id
    ]

    credit_specification {
        cpu_credits = "standard"
    }

    root_block_device {
        delete_on_termination = false
        encrypted             = true
        kms_key_id            = aws_kms_key.default-data-key.arn
        volume_size           = 80
        volume_type           = "gp3"
    }
    timeouts {}
}