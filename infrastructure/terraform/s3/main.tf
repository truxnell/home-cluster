terraform {
  required_providers {
     b2 = {
       source  = "Backblaze/b2"
       version = "0.8.9"
     }

     minio = {
       source = "aminueza/minio"
       version = "2.2.0"
     }
  doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}
