
provider "b2" {

  application_key = data.doppler_secrets.this.map.B2_APPLICATION_KEY
  application_key_id = data.doppler_secrets.this.map.B2_APPLICATION_KEY_ID

}
