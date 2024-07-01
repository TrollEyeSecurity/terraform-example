# ----------------------------------------------------------------------------------------------------------------------
# Create a Project
# ----------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_project" "atlas-project" {
  org_id = var.mongodb.atlas_org_id
  name = var.mongodb.atlas_project_name
}

# ----------------------------------------------------------------------------------------------------------------------
# Create an Atlas Advanced Cluster
# ----------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_advanced_cluster" "atlas-cluster" {
  project_id = mongodbatlas_project.atlas-project.id
  name = "${var.mongodb.atlas_project_name}-cluster"
  cluster_type = "REPLICASET"
  mongo_db_major_version = var.mongodb.mongodb_version
  replication_specs {
    num_shards = 1
    region_configs {
      electable_specs {
        instance_size = var.mongodb.cluster_instance_size_name
        node_count    = 3
      }
      analytics_specs {
        instance_size = var.mongodb.cluster_instance_size_name
        node_count    = 1
      }
      priority        = 7
      provider_name = var.mongodb.cloud_provider
      region_name     = var.mongodb.atlas_region
    }
  }
  depends_on = [mongodbatlas_privatelink_endpoint_service.atlas-ep-svc]
}

# ----------------------------------------------------------------------------------------------------------------------
# Create a Database User
# ----------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_database_user" "db-user" {
  username = var.mongodb.mongodb_user
  password = var.mongodb-secrets.mongodb_password
  project_id = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "${var.mongodb.atlas_project_name}-db"
  }
}
