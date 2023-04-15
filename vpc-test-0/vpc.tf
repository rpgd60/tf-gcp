resource "google_compute_network" "vpc" {
  count                    = var.num_vpcs
  name                     = "vpc-${count.index}"
  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
  mtu                      = 1460
}

## Subnets


resource "google_compute_subnetwork" "sub00-main" {
  name          = "sub-vpc0-${var.region}"
  ip_cidr_range = "10.1.0.0/24"
  # region        = var.region
  network          = google_compute_network.vpc[0].id
  ipv6_access_type = "INTERNAL"
  stack_type       = "IPV4_IPV6"

  log_config {
    aggregation_interval = "INTERVAL_1_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "sub01-sec" {
  provider         = google.sec_region
  name             = "sub-vpc0-${var.sec_region}"
  ip_cidr_range    = "192.168.0.0/24"
  network          = google_compute_network.vpc[0].id
  ipv6_access_type = "INTERNAL"
  stack_type       = "IPV4_IPV6"
  log_config {
    aggregation_interval = "INTERVAL_1_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

# resource "google_compute_subnetwork" "sub10-main" {
#   count = var.num_vpcs >= 1 ? 1: 0
#   name          = "sub-vpc1-${var.region}"
#   ip_cidr_range = "10.1.0.0/24"
#   # region        = var.region
#   network = google_compute_network.vpc[1].id
#   ipv6_access_type = "INTERNAL"
#   stack_type       = "IPV4_IPV6"
#   log_config {
#     aggregation_interval = "INTERVAL_1_MIN"
#     flow_sampling        = 0.5
#     metadata             = "INCLUDE_ALL_METADATA"
#   }
# }

# resource "google_compute_subnetwork" "sub11-sec" {
#   count = var.num_vpcs >= 1 ? 1: 0
#   provider      = google.sec_region
#   name          = "sub-vpc1-${var.sec_region}"
#   ip_cidr_range = "10.1.1.0/24"
#   network       = google_compute_network.vpc[1].id
#   ipv6_access_type = "INTERNAL"
#   stack_type       = "IPV4_IPV6"
#   log_config {
#     aggregation_interval = "INTERVAL_1_MIN"
#     flow_sampling        = 0.5
#     metadata             = "INCLUDE_ALL_METADATA"
#   }
#   }

## Firewall rules

resource "google_compute_firewall" "ssh" {
  count = var.num_vpcs
  name  = "allow-ssh-${count.index}"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "ssh_v6" {
  count = var.num_vpcs
  name  = "allow-ssh-v6-${count.index}"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["::/0"]
  target_tags   = ["ssh"]
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
resource "google_compute_firewall" "web" {
  count = var.num_vpcs
  name  = "allow-web-${count.index}"
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "web_v6" {
  count = var.num_vpcs
  name  = "allow-web-v6-${count.index}"
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["::/0"]
  target_tags   = ["web"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
resource "google_compute_firewall" "icmp" {
  count = var.num_vpcs
  name  = "allow-icmp-${count.index}"
  allow {
    protocol = "icmp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["icmp"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "icmp_v6" {
  count = var.num_vpcs
  name  = "allow-icmp-v6-${count.index}"
  allow {
    ## 58 is protocol for ICMP-v6 
    protocol = "58"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc[count.index].id
  priority      = var.def_fw_rule_priority
  source_ranges = ["::/0"]
  target_tags   = ["icmp"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}