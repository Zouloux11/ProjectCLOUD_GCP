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

resource "google_compute_instance" "workers" {
  count        = 3
  name         = "worker-${count.index + 1}"
  machine_type = "e2-standard-2"
  zone         = var.gcp_zone
  tags         = ["workers"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 24
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config{}
  }

  service_account {
    email  = google_service_account.cluster_sa.email
    scopes = ["cloud-platform"]
  }
  
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "e2-medium"
  zone         = var.gcp_zone
  tags         = ["master"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config{}
  }

  service_account {
    email  = google_service_account.cluster_sa.email
    scopes = ["cloud-platform"]
  }
  
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance" "edge" {
  name         = "edge"
  machine_type = "e2-highmem-2"
  zone         = var.gcp_zone
  tags         = ["edge"]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 50 
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config{}
  }

  service_account {
    email  = google_service_account.cluster_sa.email
    scopes = ["cloud-platform"]
  }
  
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "allow_spark_ui" {
  name    = "allow-spark-ui"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  description   = "Allow Spark UI access"
}

resource "google_compute_firewall" "allow_hdfs_ui" {
  name    = "allow-hdfs-ui"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["50070", "9870"]
  }

  source_ranges = ["0.0.0.0/0"]
  description   = "Allow HDFS UI access"
}