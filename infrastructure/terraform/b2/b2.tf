
resource "b2_bucket" "trux-restic-backup-C893E3" {

  bucket_name = "trux-restic-backup-C893E3"
  bucket_type = "allPrivate"

}

resource "b2_application_key" "nas-restic" {
  key_name  = "nas-restic"
  bucket_id = b2_bucket.trux-restic-backup-C893E3.id
  capabilities = [
    "deleteFiles",
    "listAllBucketNames",
    "listBuckets",
    "listFiles",
    "readBuckets",
    "readFiles",
    "shareFiles",
    "writeFiles"
  ]
}


resource "doppler_secret" "b2-app-key-id" {
  project = "tf-b2"
  config = "prd"
  name = "B2_APP_KEY_ID"
  value = b2_application_key.nas-restic.application_key_id
}

resource "doppler_secret" "b2-app-key" {
  project = "tf-b2"
  config = "prd"
  name = "B2_APP_KEY"
  value = b2_application_key.nas-restic.application_key
}
