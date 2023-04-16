locals {
  minio_buckets = [
    "thanos",
    "volsync",
    "zalando-postgres",
    "loki"
  ]
}

module "minio_bucket" {
  for_each         = toset(local.minio_buckets)
  source           = "./modules/minio_bucket"
  bucket_name      = each.key
  is_public        = false

  owner_access_key = lookup(data.doppler_secrets.this.map, "${each.key}_access_key", null)
  owner_secret_key = lookup(data.doppler_secrets.this.map, "${each.key}_secret_key", null)
  providers = {
    minio = minio.nas
  }
}

output "minio_bucket_outputs" {
  value     = module.minio_bucket
  sensitive = true
}
