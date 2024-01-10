terraform {
  required_providers {
    b2 = {
       source  = "Backblaze/b2"
       version = "0.8.9"
     }

    doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}
