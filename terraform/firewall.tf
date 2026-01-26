resource "google_compute_firewall" "allow_ssh_iap" {
  name          = "allow-ssh-iap"
  network       = google_compute_network.custom_vpc.name
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["master", "workers", "edge"]
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/24"]
}

resource "google_compute_firewall" "allow_spark_ui" {
  name    = "allow-spark-ui"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  description   = "Allow Spark UI access (from outside)"
}

resource "google_compute_firewall" "allow_hdfs_ui" {
  name    = "allow-hdfs-ui"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["50070", "9870"]
  }

  source_ranges = ["0.0.0.0/0"]
  description   = "Allow HDFS UI access (from outside)"
}