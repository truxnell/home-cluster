provider "minio" {
  alias  = "nas"
  minio_server   = "s3.trux.dev"
  minio_user     = data.doppler_secrets.this.map.MINIO_USER
  minio_password = data.doppler_secrets.this.map.MINIO_PASSWORD
  minio_ssl      = true
}
