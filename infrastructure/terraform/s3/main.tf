terraform {
  required_providers {
     b2 = {
       source  = "Backblaze/b2"
       version = "0.8.4"
     }

     minio = {
       source = "aminueza/minio"
       version = "1.16.0"
     }
  doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}
