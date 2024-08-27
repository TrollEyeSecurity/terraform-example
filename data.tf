# ----------------------------------------------------------------------------------------------------------------------
# variables
# ----------------------------------------------------------------------------------------------------------------------
variable "management_addrs" {}
variable "instance_type" {}
variable "aws-access-key" {}
variable "aws-secret-key" {}
variable "aws-region" {}
variable "aws-az" {}
variable "aws-ecs-cluster" {}
variable "tenancy" {}
variable "ssl-cert" {}
variable "env" {}
variable "mongodb" {}
variable "mongodb-secrets" {}
variable "elasticache_auth" {}
variable "mq-secrets" {}
variable "aws-account-id" {}
#-----------------------------------------------------------------------------------------------------------------------
# data
# ----------------------------------------------------------------------------------------------------------------------

data "aws_caller_identity" "current" {

}

#-----------------------------------------------------------------------------------------------------------------------
# Ubuntu AMI
# ----------------------------------------------------------------------------------------------------------------------
data "aws_ami" "ubuntu-2204" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240301"]
    }
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

#-----------------------------------------------------------------------------------------------------------------------
# Ubuntu AMI
# ----------------------------------------------------------------------------------------------------------------------
data "aws_ami" "ccscanner" {
    most_recent = true
    owners = ["749985416486"]
    filter {
        name = "name"
        values = ["ccscanner-1719869458"]
    }
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}
