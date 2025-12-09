resource "google_compute_network" "custom_vpc" {
  name = "custom-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-euw1"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.custom_vpc.self_link
}

resource "google_compute_instance" "vms" {
  count        = 4
  name         = "vm-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = var.gcp_zone
  tags         = ["vms"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
  }
}

