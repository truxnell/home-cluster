
resource "b2_bucket" "trux-kopia-backup-C893E3" {

  bucket_name = "trux-kopia-backup-C893E3"
  bucket_type = "allPrivate"

}

resource "b2_bucket" "trux-volsync-backup-A73B8D" {

  bucket_name = "trux-volsync-backup-A73B8D"
  bucket_type = "allPrivate"

}


resource "b2_application_key" "nas-restic" {
  key_name  = "nas-restic"
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
  name = "B2_APPLICATION_KEY_ID"
  value = b2_application_key.nas-restic.application_key_id
}

resource "doppler_secret" "b2-app-key" {
  project = "tf-b2"
  config = "prd"
  name = "B2_APPLICATION_KEY"
  value = b2_application_key.nas-restic.application_key
}
