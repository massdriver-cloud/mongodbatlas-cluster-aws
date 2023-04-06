locals {
  vpc_id     = element(split("/", var.vpc.data.infrastructure.arn), 1)
  subnet_ids = [for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet.arn), 1)]
}

module "mongodb" {
  source = "github.com/massdriver-cloud/terraform-modules//mongodbatlas/cluster-aws?ref=efb8551"

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

// Private Endpoints can use any port from 1024 to 65535
// https://www.mongodb.com/docs/atlas/security-private-endpoint/#port-ranges-used-for-private-endpoints
resource "aws_security_group_rule" "vpc_ingress" {
  count             = 1
  description       = "Allow VPC to access to MongoDB Atlas cluster ${var.md_metadata.name_prefix}"
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc.data.infrastructure.cidr]
  security_group_id = module.mongodb.security_group_id
}
