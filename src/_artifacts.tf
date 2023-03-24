locals {
  data_infrastructure = {
    project_id = module.mongodb.project_id
    cluster_id = module.mongodb.cluster_id
  }
  data_authentication = {
    username = module.mongodb.username
    password = module.mongodb.password
    hostname = module.mongodb.cluster_srv_connection_url
    port     = 27017
  }
}

resource "massdriver_artifact" "mongodb" {
  field                = "mongodb"
  provider_resource_id = module.mongodb.cluster_id
  name                 = "MongoDB Atlas Cluster ${module.mongodb.cluster_name}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.data_authentication
      }
      specs = {
        mongo = {
          version = module.mongodb.version
        }
      }
    }
  )
}
