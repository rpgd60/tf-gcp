# region  = "europe-west1"
region     = "europe-west4" ## Netherlands - chosen for T2A Series availability
zone       = ["europe-west4-a", "europe-west4-b"]
num_vpcs   = 1
num_vms    = 2
num_debian_vms = 2
sec_region = "us-central1"
sec_zone   = ["us-central1-a", "us-central1-b"]

machine_type = "t2a-standard-1"
# image = "debian-cloud/debian-11"
# image = "debian-cloud/debian-11-arm64"
image = "ubuntu-2204-lts-arm64"
# project = "alpha-382811"
project     = "meteo-376317"
environment = "dev"

