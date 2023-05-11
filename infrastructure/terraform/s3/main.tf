terraform {
  required_providers {
     b2 = {
       source  = "Backblaze/b2"
       version = "0.8.4"
     }

     minio = {
       source = "aminueza/minio"
       version = "1.15.2"
     }
  doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}
