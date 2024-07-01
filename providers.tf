# ----------------------------------------------------------------------------------------------------------------------
# providers
# ----------------------------------------------------------------------------------------------------------------------
provider "aws" {
    region = var.aws-region.us-east-1
    access_key = var.aws-access-key.default
    secret_key = var.aws-secret-key.default
}

provider "mongodbatlas" {
  public_key  = var.mongodb.public_key
  private_key = var.mongodb-secrets.private_key
}

terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
}