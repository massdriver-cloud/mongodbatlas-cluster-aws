locals {
  vpc_id     = element(split("/", var.vpc.data.infrastructure.arn), 1)
  subnet_ids = [for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet.arn), 1)]
}

module "mongodb" {
  source = "github.com/massdriver-cloud/terraform-modules//mongodbatlas/cluster-aws?ref=c433559"

  mongodb_organization_id        = var.mongodbatlas_creds.organization_id
  name                           = var.md_metadata.name_prefix
  region                         = var.vpc.specs.aws.region
  mongodb_version                = var.database.version
  cluster_type                   = var.database.cluster_type
  num_shards                     = try(var.database.num_shards, null)
  termination_protection_enabled = var.database.termination_protection_enabled
  vpc_id                         = local.vpc_id
  subnet_ids                     = local.subnet_ids
  instance_size                  = var.database.autoscaling.instance_size_min
  min_instance_size              = var.database.autoscaling.instance_size_min
  max_instance_size              = var.database.autoscaling.instance_size_max
  electable_node_count           = var.database.electable_node_count
  ebs_volume_type                = var.storage.ebs_volume_type
  disk_iops                      = try(var.storage.iops, null)
  disk_size_gb                   = var.storage.size_gb
  backup_enabled                 = var.backup.enabled
  backup_schedule                = try(var.backup.schedule, [])
  pit_enabled                    = try(var.backup.continuous, null)
  labels                         = var.md_metadata.default_tags
}