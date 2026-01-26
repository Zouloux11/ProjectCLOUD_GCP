output "master_ip" {
  value = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
}

output "worker_ips" {
  value = google_compute_instance.workers[*].network_interface[0].access_config[0].nat_ip
}

output "edge_ip" {
  value = google_compute_instance.edge.network_interface[0].access_config[0].nat_ip
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    master_ip = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
    worker_ips = google_compute_instance.workers[*].network_interface[0].access_config[0].nat_ip
    edge_ip = google_compute_instance.edge.network_interface[0].access_config[0].nat_ip
  })
  filename = "${path.module}/../ansible/inventory.ini"
}