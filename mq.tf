# ----------------------------------------------------------------------------------------------------------------------
# aws mq broker
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_mq_broker" "mq" {
  broker_name = "${var.env.shortname}-mq"
  configuration {
    id       = aws_mq_configuration.mq-configuration.id
    revision = aws_mq_configuration.mq-configuration.latest_revision
  }
  tags = {
    "Name"    = upper("mq")
  }
  engine_type        = "RabbitMQ"
  engine_version     = "3.11.28"
  host_instance_type = var.instance_type.default.mq
  security_groups    = [aws_security_group.mq-sg.id]
  subnet_ids = [
    #aws_subnet.backend-a.id,
    #aws_subnet.backend-b.id,
    aws_subnet.backend-c.id
  ]
  user {
    username = "mq-user"
    password = var.mq-secrets.password
  }
  publicly_accessible = false
}

# ----------------------------------------------------------------------------------------------------------------------
# aws mq configuration
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_mq_configuration" "mq-configuration" {
  description    = "RabbitMQ 3.11.28 configuration"
  name           = "${var.env.shortname}-mq-configuration"
  engine_type    = "RabbitMQ"
  engine_version = "3.11.28"
  data = <<DATA
# Default RabbitMQ delivery acknowledgement timeout is 30 minutes in milliseconds
consumer_timeout = 1800000
DATA
}