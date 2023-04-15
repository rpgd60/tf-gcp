variable "region" {
  description = "GCP Region"
}

variable "zone" {
  description = "Zone within region"
}

variable "project" {
  # default = "alpha-382811"
  default = "meteo-376317"
}

variable "machine_type" {
  description = "Machine type e.g. E2, N2, T2A"
}

variable "environment" {
  description = "Environment (prod, test, dev)"
}