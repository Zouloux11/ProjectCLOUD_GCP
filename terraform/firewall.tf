resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.custom_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["vms"]          
  source_ranges = ["35.235.240.0/20"]
  direction     = "INGRESS"
}


resource "google_compute_firewall" "allow_internal_icmp" {
  name    = "allow-internal-icmp"
  network = google_compute_network.custom_vpc.self_link

  allow {
    protocol = "icmp"
  }

  target_tags = ["vms"]
  source_ranges = ["10.0.0.0/16"]
  direction     = "INGRESS"
}
