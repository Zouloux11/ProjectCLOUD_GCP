variable "gcp_project" {
  type        = string
  default     = "gcpproject-484418"
}
variable "gcp_zone" {
  type        = string
  default     = "europe-west1-b"
}

variable "gcp_region" {
  type        = string
  default     = "europe-west1"
}

variable "authorized_users" {
  type        = list(string)
  default     = [
    "lescopantoine@gmail.com",
    "caploic@outlook.fr"
  ]
}