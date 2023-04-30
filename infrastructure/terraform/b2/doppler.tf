
# Define a variable so we can pass in our token
variable "doppler_token" {
  type = string
  description = "A token to authenticate with Doppler"
}

# Configure the Doppler provider with the token
provider "doppler" {
  doppler_token = var.doppler_token
}

# Define our data source to fetch secrets
data "doppler_secrets" "this" {
  project="tf-b2"
  config="prd"
}
