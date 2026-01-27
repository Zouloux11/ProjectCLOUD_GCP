resource "google_project_iam_member" "admins" {
  for_each = toset(var.authorized_users)
  
  project = var.gcp_project
  role    = "roles/compute.osAdminLogin"
  member  = "user:${each.value}"
}