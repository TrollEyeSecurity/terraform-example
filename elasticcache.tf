# ----------------------------------------------------------------------------------------------------------------------
# Elasticache Redis cluster
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_elasticache_replication_group" "elasticache" {
  automatic_failover_enabled  = true
  preferred_cache_cluster_azs = [
    var.aws-az.us-east-1a,
    var.aws-az.us-east-1b,
    var.aws-az.us-east-1c
  ]
  engine_version       = "7.1"
  replication_group_id        = "${var.env.shortname}-redis"
  description                 = "${var.env.shortname} Elasticache"
  node_type                   = var.instance_type.default.redis-cache
  num_cache_clusters          = 3
  port                        = 6379
  subnet_group_name = aws_elasticache_subnet_group.elasticache-subnet-group.name
  security_group_ids = [aws_security_group.elasticache-sg.id]
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  transit_encryption_mode = "required"
  auth_token = var.elasticache_auth.token
}

# ----------------------------------------------------------------------------------------------------------------------
# Elasticache Redis cluster subnet group
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name       = "elasticache-${var.env.shortname}-subnet-group"
  subnet_ids = [
    aws_subnet.backend-a.id,
    aws_subnet.backend-b.id,
    aws_subnet.backend-c.id
  ]
}