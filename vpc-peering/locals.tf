locals {
  common_labels = {
    "created_by"  = "terraform"
    "environment" = var.environment
  }
  name_prefix = "${var.company}-${var.environment}"
}

