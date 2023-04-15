variable "region" {
  description = "GCP main region"
  default     = "europe-west4" ## Chosen for ARM 
  type        = string
}

variable "num_vpcs" {
  type    = number
  default = 1
  validation {
    condition     = var.num_vpcs > 0 && var.num_vpcs <= 4
    error_message = "number of vpcs must be min 1 and max 4"
  }
}

variable "num_vms" {
  description = "number of VMs per region"
  type        = number
  default     = 1
  validation {
    condition     = var.num_vms > 0 && var.num_vms <= 4
    error_message = "number of vms per region must be min 1 and max 4"
  }
}

variable "num_debian_vms" {
  description = "number of debian VMs per region"
  type        = number
  default     = 0
  validation {
    condition     = var.num_debian_vms >= 0 && var.num_debian_vms <= 4
    error_message = "number of debian vms per region must be min 0 and max 4"
  }
}

variable "region2" {
  description = "GCP secondary region"
  default     = "us-central1"
  type        = string
}
variable "zone" {
  description = "Zones within region"
  type        = list(string)
}

variable "zone2" {
  description = "Zones within secondary region"
  type        = list(string)
}

variable "project" {
  # default = "alpha-382811"
  default = "meteo-376317"
  type    = string
}

variable "company" {
  default = "acme"
  type    = string
}

variable "machine_type" {
  description = "Machine type e.g. E2, N2, T2A"
  type        = string
}

variable "environment" {
  description = "Environment (prod, test, dev)"
  type        = string
}

variable "def_fw_rule_priority" {
  description = "Default value for firewall rule priority"
  type        = number
  default     = 1000
}

variable "image" {
  description = "image to deploy"
  type        = string
}


