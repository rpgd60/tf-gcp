resource "google_compute_network" "vpc_network" {
  name                    = "custom1"
  auto_create_subnetworks = false
  mtu                     = 1460

}

resource "google_compute_subnetwork" "custom" {
  name          = "custom1-${var.region}"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}


resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]

}

resource "google_compute_firewall" "web" {
  name = "allow-web"
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}


# Create a single Compute Engine instance
resource "google_compute_instance" "vm_arm" {
  name         = "flask-vm"
  machine_type = var.machine_type
  # zone         = "${var.region}-a"
  zone = var.zone
  tags = ["ssh", "web"]
  labels = local.common_labels

  boot_disk {

    initialize_params {

      # image = "debian-cloud/debian-11"
      image = "debian-cloud/debian-11-arm64"

    }

  }


  # Install Flask
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.custom.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

