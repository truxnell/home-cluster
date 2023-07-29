terraform {
  required_providers {
     b2 = {
       source  = "Backblaze/b2"
       version = "0.8.4"
     }

     minio = {
       source = "aminueza/minio"
       version = "1.17.1"
     }
  doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}
