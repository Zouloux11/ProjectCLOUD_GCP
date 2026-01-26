resource "google_service_account" "cluster_sa" {
  account_id   = "cluster-sa"
  display_name = "Service account pour les VMs"
}

resource "google_project_iam_member" "sa_logs" {
  project = var.gcp_project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cluster_sa.email}"
}

resource "google_project_iam_member" "sa_monitoring" {
  project = var.gcp_project
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cluster_sa.email}"
}

resource "google_project_iam_member" "admins" {
  for_each = toset(var.authorized_users)
  
  project = var.gcp_project
  role    = "roles/compute.osAdminLogin"
  member  = "user:${each.value}"
}