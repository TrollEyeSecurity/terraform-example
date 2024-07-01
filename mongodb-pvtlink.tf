# ----------------------------------------------------------------------------------------------------------------------
# MongoDB Private Link Endpoint
# ----------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_privatelink_endpoint" "atlas-pl-ep" {
  project_id    = mongodbatlas_project.atlas-project.id
  provider_name = var.mongodb.cloud_provider
  region        = var.mongodb.aws_region
}

# ----------------------------------------------------------------------------------------------------------------------
# AWS VPC endpoint
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint" "mongodb-endpoint" {
  tags = {
    "Name"    = upper("mongodb-endpoint")
  }
  vpc_id             = aws_vpc.vpc-1.id
  service_name       = mongodbatlas_privatelink_endpoint.atlas-pl-ep.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [
    aws_subnet.backend-a.id,
    aws_subnet.backend-b.id,
    aws_subnet.backend-c.id
  ]
  security_group_ids = [
    aws_security_group.mongodb-pvtlink.id
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# MongoDB Private Endpoint Service
# ----------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_privatelink_endpoint_service" "atlas-ep-svc" {
  project_id          = mongodbatlas_privatelink_endpoint.atlas-pl-ep.project_id
  endpoint_service_id = aws_vpc_endpoint.mongodb-endpoint.id
  private_link_id     = mongodbatlas_privatelink_endpoint.atlas-pl-ep.private_link_id
  provider_name       = var.mongodb.cloud_provider
}