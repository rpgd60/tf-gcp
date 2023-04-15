# Create a single Compute Engine instance
resource "google_compute_instance" "vma" {
  count        = var.num_vms
  name         = "vma-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone[count.index]
  tags         = ["ssh", "web", "icmp"]
  labels       = local.common_labels

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  # Install web server
  # metadata_startup_script = "sudo rm /var/lib/man-db/auto-update; sudo apt-get update; sudo apt-get install -y nginx-light"
  metadata_startup_script = file("${path.module}/startup_ubuntu.sh")


  network_interface {
    subnetwork = google_compute_subnetwork.sub00-main.id
    stack_type = "IPV4_IPV6"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_instance" "vmb" {
  provider = google.sec_region
  count    = var.num_vms
  name         = "vmb-${count.index}"
  machine_type = var.machine_type
  tags         = ["ssh", "web", "icmp"]
  labels       = local.common_labels
  zone         = var.sec_zone[count.index]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  # Install Flask
  # metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
  metadata_startup_script = file("${path.module}/startup_ubuntu.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.sub01-sec.id
    stack_type = "IPV4_IPV6"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_instance" "vmc" {
  provider = google 
  count    =  var.num_debian_vms
  name         = "vmc-${count.index}"
  machine_type = var.machine_type
  tags         = ["ssh", "web", "icmp"]
  labels       = local.common_labels
  zone         = var.zone[count.index] 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11-arm64"
    }
  }
  # Install Flask
  # metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
  metadata_startup_script = file("${path.module}/startup_debian.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.sub00-main.id
    stack_type = "IPV4_IPV6"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}